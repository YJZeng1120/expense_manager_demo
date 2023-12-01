import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:expense_manager_app/models/news.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class NewsApi {
  Future<Either<String, List<News>>> fetchNews({int retryCount = 3}) async {
    try {
      const String fullUrl = "$endpoint/news-list?language=en_US";
      final uri = Uri.parse(fullUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> responseBody =
            jsonDecode(utf8.decode(response.bodyBytes));
        final List<News> newsList =
            responseBody.map((e) => News.fromJson(e)).toList();

        return right(newsList);
      } else {
        final String errorMessage = jsonDecode(response.body)["message"];
        print("[${response.statusCode}] $errorMessage");
        return left("[${response.statusCode}] $errorMessage");
      }
    } catch (e) {
      // 網路異常
      if (e is http.ClientException || e is SocketException) {
        print('Network error: $e');
        return left('Network error');
      }

      // 其他異常
      print('Unknown error: $e');
      if (retryCount > 0) {
        // 延遲200毫秒後重新獲取新聞
        await Future.delayed(const Duration(milliseconds: 200));
        return fetchNews(retryCount: retryCount - 1);
      } else {
        // 達到最大重試次數，回傳錯誤訊息
        return left('Unknown error occurred');
      }
    }
  }

  Future<Either<String, News>> fetchNewsDetail(
    String id,
  ) async {
    try {
      final String fullUrl = "$endpoint/news?id=$id&language=en_US";
      final uri = Uri.parse(fullUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
        final News newsDetail = News.fromJson(responseBody);

        return right(newsDetail);
      } else {
        final String errorMessage = jsonDecode(response.body)["message"];
        print("[${response.statusCode}] $errorMessage");
        return left("[${response.statusCode}] $errorMessage");
      }
    } catch (e) {
      // 網路異常
      if (e is http.ClientException || e is SocketException) {
        print('Network error: $e');
        return left('Network error');
      }
      // 其他異常
      print('Unknown error: $e');
      return left('Unknown error occurred');
    }
  }
}
