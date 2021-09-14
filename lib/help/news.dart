import 'dart:convert';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:my_news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews(String search) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?q=$search&country=in&apiKey=1ad2f902e50643d682a75f7bd0052292");

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element["content"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"] ?? "",
              description: element["description"] ?? '',
              url: element["url"] ?? "",
              urlToImage: element["urlToImage"] ?? "",
              content: element["content"] ?? "");
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=1ad2f902e50643d682a75f7bd0052292");

    http.Response response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element["content"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"]);
          news.add(articleModel);
        }
      });
    }
  }
}
