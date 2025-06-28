import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';

class AppRoutes {
  static const auth = '/auth';
  static const home = '/home';
  static const newsDetail = '/news-detail';

  static final routes = [
    GetPage(name: auth, page: () => const AuthView(), binding: AuthBinding()),
    GetPage(name: home, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(
      name: newsDetail,
      page: () => const NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
  ];
}
