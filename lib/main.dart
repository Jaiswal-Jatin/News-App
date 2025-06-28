import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/bindings/app_binding.dart';
import 'app/routes/app_routes.dart';
import 'app/data/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NewsFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'system',
      ),
      initialBinding: AppBinding(),
      initialRoute: StorageService.isLoggedIn ? AppRoutes.home : AppRoutes.auth,
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
