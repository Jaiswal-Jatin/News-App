import 'package:get/get.dart';
import '../../../data/models/news_model.dart';
import '../../../data/services/news_service.dart';
import '../../../data/services/storage_service.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final articles = <Article>[].obs;
  final selectedCategory = 'general'.obs;
  final searchQuery = ''.obs;
  final favorites = <String>[].obs;

  final categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  final categoriesHindi = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
    fetchTopHeadlines();
  }

  void loadFavorites() {
    favorites.value = StorageService.favorites;
  }

  Future<void> fetchTopHeadlines() async {
    isLoading.value = true;
    try {
      final newsModel = await NewsService.getTopHeadlines();
      articles.value = newsModel.articles ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch news');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNewsByCategory(String category) async {
    selectedCategory.value = category;
    isLoading.value = true;
    try {
      final newsModel = await NewsService.getNewsByCategory(category);
      articles.value = newsModel.articles ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch news by category');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    searchQuery.value = query;
    isLoading.value = true;
    try {
      final newsModel = await NewsService.searchNews(query);
      articles.value = newsModel.articles ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to search news');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshNews() {
    if (searchQuery.value.isNotEmpty) {
      searchNews(searchQuery.value);
    } else {
      fetchNewsByCategory(selectedCategory.value);
    }
  }

  Future<void> toggleFavorite(String articleId) async {
    if (favorites.contains(articleId)) {
      await StorageService.removeFromFavorites(articleId);
      favorites.remove(articleId);
      Get.snackbar('Removed', 'Removed from favorites');
    } else {
      await StorageService.addToFavorites(articleId);
      favorites.add(articleId);
      Get.snackbar('Added', 'Added to favorites');
    }
  }

  bool isFavorite(String articleId) {
    return favorites.contains(articleId);
  }

  String getCategoryHindi(String category) {
    int index = categories.indexOf(category);
    if (index != -1 && index < categoriesHindi.length) {
      return categoriesHindi[index];
    }
    return category;
  }
}
