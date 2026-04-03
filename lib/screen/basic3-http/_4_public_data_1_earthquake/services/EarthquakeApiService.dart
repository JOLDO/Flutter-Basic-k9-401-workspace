import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/EarthquakeInfo.dart';

class EarthquakeApiService {
  static const String _baseUrl =
      'https://apis.data.go.kr/1360000/EqkInfoService/getEqkMsg';

  // ✅ 디코딩된 원본 키 사용 (Uri가 자동으로 인코딩해줌)
  // 기존: 'ALRX9...%2F...' → ❌ 이중 인코딩 발생
  // 수정: 'ALRX9.../...'  → ✅ Uri가 올바르게 인코딩
  static const String _serviceKey =
      '본인의 api 키2';


  static Future<List<EarthquakeInfo>> fetchEarthquakes({
    int pageNo = 1,
    int numOfRows = 10,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'serviceKey': _serviceKey, // Uri가 자동 인코딩
        'pageNo': pageNo.toString(),
        'numOfRows': numOfRows.toString(),
        'dataType': 'JSON',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));

      // ✅ null 안전 처리 추가 (데이터 없을 시 빈 리스트 반환)
      final body = data['response']['body'];
      final items = body['items'];
      if (items == null || items['item'] == null) return [];

      final itemList = items['item'];
      // ✅ 단건 조회 시 List가 아닌 Map으로 올 수 있음
      if (itemList is Map) {
        return [EarthquakeInfo.fromJson(itemList as Map<String, dynamic>)];
      }
      return (itemList as List)
          .map((item) => EarthquakeInfo.fromJson(item))
          .toList();
    } else {
      throw Exception('데이터 로드 실패: ${response.statusCode}');
    }
  }
}