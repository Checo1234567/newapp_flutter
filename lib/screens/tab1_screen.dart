import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/widgets/widgets.dart';
import '../services/services.dart';

class Tab1Screen extends StatelessWidget {
  const Tab1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests'),
      ),
      body: NewsList(newsService.headlines),
    );
  }
}
