import 'package:get/get.dart';
import '../../../data/models/news_model.dart';

class NewsDetailController extends GetxController {
  final article = Rx<Article?>(null);

  @override
  void onInit() {
    super.onInit();
    article.value = Get.arguments as Article?;
  }
}
