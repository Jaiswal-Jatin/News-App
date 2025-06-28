import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controllers/home_controller.dart';
import '../../news_detail/views/news_detail_view.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            // _buildCategoryTabs(),
            Expanded(child: _buildNewsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.newspaper, size: 32, color: Colors.blue),
          const SizedBox(width: 12),
          const Text(
            'NewsFlow',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: controller.refreshNews,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => Get.find<AuthController>().logout(),
                child: const Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onSubmitted: controller.searchNews,
        decoration: const InputDecoration(
          hintText: 'Search news...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected = controller.selectedCategory.value == category;

            return GestureDetector(
              onTap: () => controller.fetchNewsByCategory(category),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    controller.getCategoryHindi(category).toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.articles.isEmpty) {
        return const Center(child: Text('No articles found'));
      }

      return RefreshIndicator(
        onRefresh: () async => controller.refreshNews(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.articles.length,
          itemBuilder: (context, index) {
            final article = controller.articles[index];
            return _buildNewsCard(article);
          },
        ),
      );
    });
  }

  Widget _buildNewsCard(article) {
    return GestureDetector(
      onTap: () => Get.to(() => NewsDetailView(), arguments: article),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (article.source?.name != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        article.source!.name!,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (article.title != null)
                    Text(
                      article.title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  if (article.description != null)
                    Text(
                      article.description!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (article.author != null)
                        Expanded(
                          child: Text(
                            'By ${article.author}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      IconButton(
                        onPressed: () =>
                            controller.toggleFavorite(article.title ?? ''),
                        icon: Icon(
                          controller.isFavorite(article.title ?? '')
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: controller.isFavorite(article.title ?? '')
                              ? Colors.red
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                      if (article.publishedAt != null)
                        Text(
                          timeago.format(article.publishedAt!),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
