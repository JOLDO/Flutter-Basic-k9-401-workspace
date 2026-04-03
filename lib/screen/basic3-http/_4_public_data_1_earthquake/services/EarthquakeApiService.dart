import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/EarthquakeInfo.dart';

class EarthquakeApiService {
  // ✅ https:// 사용 (Android http 차단 문제 방지)
  // 공공데이터포털 > 마이페이지 > 개발계정 > 상세보기에서 확인
  static const String _baseUrl =
      'https://apis.data.go.kr/1360000/EqkInfoService/getEqkMsg';

  // ✅ 반드시 "일반 인증키 (Decoding)" 사용
  //    %2F, %3D 같은 기호가 없는 버전
  //    Uri.replace(queryParameters)가 자동으로 인코딩해주기 때문
  // ✅ 공공데이터포털 > 마이페이지 > 개발계정 > 상세보기
  //    "일반 인증키 (Decoding)" 코피 (%2F, %3D 같은 기호 없는 버전)
  static const String _serviceKey = '여기에_Decoding_키_입력';

  // ✅ API 제한사항
  //    - fromTmFc, toTmFc 필수 파라미터 (yyyyMMddHHmm 형식)
  //    - 최대 조회 기간: 오늘 기준 3일 전까지만 허용
  //    - 해당 기간 지진 없으면 resultCode: 02 반환 (정상)
  static Future<List<EarthquakeInfo>> fetchEarthquakes({
    int pageNo = 1,
    int numOfRows = 10,
  }) async {
    final now  = DateTime.now();
    final from = now.subtract(const Duration(days: 3)); // ✅ 최대 3일 전

    // yyyyMMddHHmm 형식 변환
    String fmt(DateTime dt) =>
        '${dt.year}'
            '${dt.month.toString().padLeft(2, '0')}'
            '${dt.day.toString().padLeft(2, '0')}'
            '0000';

    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'serviceKey': _serviceKey,
        'pageNo':     pageNo.toString(),
        'numOfRows':  numOfRows.toString(),
        'dataType':   'JSON',
        'fromTmFc':   fmt(from), // ✅ 필수 - 3일 전
        'toTmFc':     fmt(now),  // ✅ 필수 - 오늘
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data       = json.decode(utf8.decode(response.bodyBytes));
      final header     = data['response']['header'];
      final resultCode = header['resultCode'] as String;

      switch (resultCode) {
        case '00': // 정상
          break;
        case '02': // DB_ERROR = 해당 기간 지진 없음 → 빈 리스트
          return [];
        default:   // 그 외 오류
          throw Exception('API 오류 ($resultCode): ${header['resultMsg']}');
      }

      final items = data['response']['body']['items'];
      if (items == null || items == '' || items['item'] == null) return [];

      final itemList = items['item'];
      // 단건 조회 시 List가 아닌 Map으로 반환될 수 있음
      if (itemList is Map) {
        return [EarthquakeInfo.fromJson(itemList as Map<String, dynamic>)];
      }
      return (itemList as List)
          .map((e) => EarthquakeInfo.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('HTTP 오류: ${response.statusCode}');
    }
  }
}