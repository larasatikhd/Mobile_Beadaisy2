import 'package:get/get.dart';
import 'package:appbaru/app/modules/home/bindings/home_binding.dart';
import 'package:appbaru/app/modules/home/bindings/welcome_binding.dart';
import 'package:appbaru/app/modules/home/views/home_view.dart';
import 'package:appbaru/app/modules/home/views/welcome.dart';
import 'package:appbaru/app/modules/register/views/register_page.dart'; // Import RegisterPage
import 'package:appbaru/app/modules/register/bindings/register_binding.dart'; // Import RegisterBinding
import 'package:appbaru/app/modules/login/views/login_page.dart'; // Import LoginPage
import 'package:appbaru/app/modules/login/bindings/login_binding.dart'; // Import LoginBinding
import 'package:appbaru/app/modules/article_detail/bindings/article_detail_bindings.dart';
import 'package:appbaru/app/modules/article_detail/views/article_detail_view.dart';
import 'package:appbaru/app/modules/article_detail/views/article_detail_web_view.dart';
import 'package:appbaru/app/modules/http_screen/views/http_view.dart';
import 'package:appbaru/app/modules/http_screen/bindings/http_bindings.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/welcome',
      page: () => WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/http',
      page: () => const HttpView(),
      binding: HttpBinding(),
    ),
    GetPage(
      name: '/article_details',
      page: () => ArticleDetailPage(article: Get.arguments),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: '/article_details_webview',
      page: () => ArticleDetailWebView(article: Get.arguments),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: '/register', 
      page: () => RegisterPage(),
      binding: RegisterBinding(), 
    ),
    GetPage(
      name: '/login', 
      page: () => LoginPage(),
      binding: LoginBinding(), 
    ),
  ]; 
}