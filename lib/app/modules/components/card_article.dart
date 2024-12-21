import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appbaru/app/routes/app_pages.dart';
import '../../data/models/article.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: article.urlToImage ?? article.title, // Use a fallback tag
          child: SizedBox(
            width: 100,
            height: 100,
            child: article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text(
                        'No Image',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
        ),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author ?? 'Unknown'),
        // Tambahkan ikon lonceng di sini
        trailing: IconButton(
          icon: Icon(Icons.notifications),  // Ikon lonceng
          onPressed: () {
            // Navigasi ke halaman detail artikel
            Get.toNamed(Routes.ARTICLE_DETAILS, arguments: article);
          },
        ),
        onTap: () {
          Get.toNamed(Routes.ARTICLE_DETAILS, arguments: article); //
        },
      ),
    );
  }
}
