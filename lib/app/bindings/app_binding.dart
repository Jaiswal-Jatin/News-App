import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/news_detail/controllers/news_detail_controller.dart';
import '../modules/auth/controllers/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NewsDetailController>(() => NewsDetailController());
  }
}
