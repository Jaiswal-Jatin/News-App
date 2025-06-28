import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../controllers/news_detail_controller.dart';

class NewsDetailView extends GetView<NewsDetailController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final article = controller.article.value;
        if (article == null) {
          return const Center(child: Text('No article data'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: article.urlToImage != null
                    ? CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, size: 50),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.article, size: 100),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (article.source?.name != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          article.source!.name!,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (article.title != null)
                      Text(
                        article.title!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (article.author != null)
                          Expanded(
                            child: Text(
                              'By ${article.author}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        if (article.publishedAt != null)
                          Text(
                            timeago.format(article.publishedAt!),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (article.description != null)
                      Text(
                        article.description!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(height: 24),
                    if (article.content != null)
                      Text(
                        article.content!,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(height: 32),
                    if (article.url != null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(article.url!),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('पूरा लेख पढ़ें'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Error', 'Could not launch URL');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not launch URL');
    }
  }
}
