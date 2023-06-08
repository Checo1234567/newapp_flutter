import 'package:flutter/material.dart';

import '../models/news_models.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.news);

  final List<Article> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _NewsData(
          article: news[index],
          index: index,
        );
      },
      itemCount: news.length,
    );
  }
}

class _NewsData extends StatelessWidget {
  final Article article;
  final int index;

  const _NewsData({required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ArticleCard(
          article: article,
          index: index,
        ),
        _TitleCard(article: article),
        _ImageCard(article: article),
      ],
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article article;

  const _ImageCard({required this.article});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: (article.urlToImage != null)
            ? FadeInImage(
                placeholder:
                    const AssetImage('assets/images/circle-loading.gif'),
                image: NetworkImage(article.urlToImage!),
              )
            : const Image(image: AssetImage('assets/images/no-image.png')));
  }
}

class _TitleCard extends StatelessWidget {
  final Article article;

  const _TitleCard({required this.article});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.article,
    required this.index,
  });

  final Article article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.indigo),
          ),
          Text(
            article.source.name,
          ),
        ],
      ),
    );
  }
}
