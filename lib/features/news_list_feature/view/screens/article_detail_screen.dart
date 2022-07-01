import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newapi_app/features/models/news_article_model/news_article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    required this.article,
    Key? key,
  }) : super(key: key);

  final NewsArticle article;
  @override
  Widget build(BuildContext context) {
    debugPrint('=imgUrl= ${article.urlToImage}');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 1.sw,
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  const Center(child: Text('News')),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  article.title ?? '',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.4.sw,
                      child: Text(
                        'Автор: ${article.author}',
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Дата: ${DateFormat('dd-MM-yyy').format(article.publishedAt!)}',
                        maxLines: 3,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  article.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
              
                ElevatedButton(
                  onPressed: () async {
                    if (await canLaunch(article.url ?? '')) {
                      await launch(article.url ?? '');
                    }
                  },
                  child: const Text('Открыть источник'),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
