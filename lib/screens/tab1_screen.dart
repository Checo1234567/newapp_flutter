import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/widgets/widgets.dart';
import '../services/services.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({super.key});

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interests'),
      ),
      body: (newsService.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : NewsList(newsService),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
