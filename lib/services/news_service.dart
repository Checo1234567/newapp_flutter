import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/models/models.dart';

class NewsService with ChangeNotifier {
  final _baseUrl = 'https://newsapi.org/v2';
  // final _baseUrl = 'newsapi.org';
  final _apiKey = 'b06b8478c63341af8a776bc4bb3b3935';

  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

  getTopHeadlines() async {
    // final url = Uri.https(_baseUrl, '/v2/top-headlines', {
    //   'country': 'ca',
    //   'apiKey': _apiKey,
    // });
    final url = '$_baseUrl/top-headlines?apiKey=$_apiKey&country=us';
    final res = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromMap(res.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
    // print('Cargando Headlines...');
  }
}
