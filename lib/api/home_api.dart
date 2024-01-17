import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsApiProvider {
  final String apiKey;
  final String baseUrl = "https://newsapi.org/v2";

  NewsApiProvider(this.apiKey);

  Future<List<ArticleModel>> getUSATopHeadlinesNews() async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': apiKey,
        'country': 'us',
        'excludeDomains': 'stackoverflow.com',
        'sortBy': 'publishedAt',
        'language': 'en',
      };

      final Uri uri = Uri.parse('$baseUrl/top-headlines').replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        final jsonData = json.decode(response.body);
        final List<dynamic>? articlesData = jsonData?['articles'];

        if (articlesData != null) {
          final articles = articlesData.map((result) => ArticleModel.fromJson(result)).toList();
          return articles;
        } else {
          debugPrint("getUSATopHeadlinesNews: articlesData is null");
          return [];
        }
      } else {
        // Error response
        debugPrint('getUSATopHeadlinesNews: Failed to load news. Status code: ${response.statusCode}');
        debugPrint('getUSATopHeadlinesNews: Response body: ${response.body}');
        throw Exception('Failed to load news');
      }
    } catch (e) {
      debugPrint('getUSATopHeadlinesNews: $e');
      return [];
    }
  }

  Future<List<ArticleModel>> getCategoryNews(String category) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': apiKey,
        'category': category,
        'excludeDomains': 'stackoverflow.com',
        'sortBy': 'publishedAt',
        'language': 'en',
      };

      final Uri uri = Uri.parse('$baseUrl/top-headlines').replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Successful response
        final jsonData = json.decode(response.body);
        final List<dynamic>? articlesData = jsonData?['articles'];

        if (articlesData != null) {
          final articles = articlesData.map((result) => ArticleModel.fromJson(result)).toList();
          return articles;
        } else {
          debugPrint("getCategoryNews: articlesData is null");
          return [];
        }
      } else {
        // Error response
        debugPrint('getCategoryNews: Failed to load news. Status code: ${response.statusCode}');
        debugPrint('getCategoryNews: Response body: ${response.body}');
        throw Exception('Failed to load news');
      }
    } catch (e) {
      debugPrint('getCategoryNews: $e');
      return [];
    }
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': apiKey,
        'q': query,
        'language': 'en',
      };

      final Uri uri =
      Uri.parse('$baseUrl/everything').replace(queryParameters: queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic>? articlesData = jsonData?['articles'];

        if (articlesData != null) {
          final articles =
          articlesData.map((result) => ArticleModel.fromJson(result)).toList();
          return articles;
        } else {
          debugPrint("searchNews: articlesData is null");
          return [];
        }
      } else {
        debugPrint('searchNews: Failed to load news. Status code: ${response.statusCode}');
        debugPrint('searchNews: Response body: ${response.body}');
        throw Exception('Failed to load news');
      }
    } catch (e) {
      debugPrint('searchNews: $e');
      return [];
    }
  }
}



