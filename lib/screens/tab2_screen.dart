import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/widgets/widgets.dart';
import 'package:news_app/models/category_models.dart';
import 'package:news_app/services/news_service.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: Column(
        children: [
          const _CategoryList(),
          Expanded(
            child: NewsList(newsService.getSelectedCategoryArticle),
          ),
        ],
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cName = categories[index].name;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _CastegoryButton(categories: categories[index]),
                  const SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CastegoryButton extends StatelessWidget {
  const _CastegoryButton({
    required this.categories,
  });

  final Category categories;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // print(categories.name);
        newsService.selectedCategory = categories.name;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categories.icon,
            color: (newsService.selectedCategory == categories.name)
                ? Colors.red
                : Colors.amber),
      ),
    );
  }
}
