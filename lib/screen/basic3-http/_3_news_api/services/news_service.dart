import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  // newsapi.org 무료 Developer 키 발급
  // https://newsapi.org/register
  static const String _apiKey = 'b7adb4f936494b3bac62f446ab7686cb';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  /// 헤드라인 뉴스 가져오기
  ///
  /// [country] 국가 코드: 'us'(미국), 'gb'(영국), 'jp'(일본) 등
  ///   ⚠️ 'kr'(한국)은 현재 NewsAPI에서 결과가 없을 수 있음
  ///   ⚠️ country 와 sources 파라미터는 함께 사용 불가
  /// [category] business | entertainment | health | science | sports | technology
  /// [pageSize] 가져올 기사 수 (최대 100, 무료 플랜 기준)
  static Future<List<NewsArticle>> fetchTopHeadlines({
    String country = 'us',   // 기본값: 미국 (kr은 결과 없음 주의)
    String category = 'general',
    int pageSize = 20,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'country':  country,
        'category': category,
        'pageSize': pageSize.toString(),
        'apiKey':   _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes))
      as Map<String, dynamic>;

      // status 가 'error' 이면 API 키 문제
      if (data['status'] == 'error') {
        throw Exception('NewsAPI 오류: ${data['message']}');
      }

      // 응답 구조: { status: 'ok', totalResults: N, articles: [...] }
      final List<dynamic> articles =
          (data['articles'] as List<dynamic>?) ?? [];

      return articles
          .map((a) => NewsArticle.fromJson(a as Map<String, dynamic>))
      // 삭제된 기사('[Removed]') 및 빈 제목 필터링
          .where((a) => a.title != '[Removed]' && a.title.isNotEmpty)
          .toList();
    } else {
      throw Exception('뉴스 로드 실패 (HTTP ${response.statusCode})');
    }
  }

  /// 특정 소스에서 뉴스 가져오기
  /// 예) sources: 'bbc-news', 'cnn', 'the-verge'
  /// ⚠️ sources 파라미터 사용 시 country/category 파라미터 사용 불가
  static Future<List<NewsArticle>> fetchBySources({
    String sources = 'bbc-news',
    int pageSize = 20,
  }) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'sources':  sources,
        'pageSize': pageSize.toString(),
        'apiKey':   _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes))
      as Map<String, dynamic>;
      if (data['status'] == 'error') {
        throw Exception('NewsAPI 오류: ${data['message']}');
      }
      final List<dynamic> articles =
          (data['articles'] as List<dynamic>?) ?? [];
      return articles
          .map((a) => NewsArticle.fromJson(a as Map<String, dynamic>))
          .where((a) => a.title != '[Removed]' && a.title.isNotEmpty)
          .toList();
    } else {
      throw Exception('뉴스 로드 실패 (HTTP ${response.statusCode})');
    }
  }
}