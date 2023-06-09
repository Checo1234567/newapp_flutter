import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/models/models.dart';

class NewsService with ChangeNotifier {
  final _baseUrl = 'https://newsapi.org/v2';
  // final _baseUrl = 'newsapi.org';
  final _apiKey = 'b06b8478c63341af8a776bc4bb3b3935';

  String _selectedCategory = 'business';

  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var element in categories) {
      categoryArticles[element.name] = [];
    }
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String category) {
    _selectedCategory = category;

    getArticlesByCategory(category);

    notifyListeners();
  }

  List<Article> get getSelectedCategoryArticle =>
      categoryArticles[selectedCategory]!;

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

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final url =
        '$_baseUrl/top-headlines?apiKey=$_apiKey&country=us&category=$category';
    final res = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromMap(res.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    // headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
