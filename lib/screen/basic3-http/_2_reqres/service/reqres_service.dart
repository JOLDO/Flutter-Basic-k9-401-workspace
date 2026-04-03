import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/reqres_user.dart';


class ReqresService {
  static const String _baseUrl = 'https://reqres.in/api/users';
  static const String _apiKey = 'pro_dd102b2a35a1df91a227cedfbc8784979d59f12c7fdbfdc53d88922302c30c91'; // ← 추가

  // 특정 페이지의 사용자 목록 가져오기 (1페이지당 6명)
  static Future<List<ReqresUser>> fetchUsers({int page = 1}) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {'page': page.toString()},
    );

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': _apiKey,
      },

    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      // 응답 구조: { data: [ {...}, {...} ], page: 1, total: 12 ... }
      final List<dynamic> items = data['data'] as List<dynamic>;
      return items
          .map((item) => ReqresUser.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('사용자 로드 실패: ${response.statusCode}');
    }
  }
}