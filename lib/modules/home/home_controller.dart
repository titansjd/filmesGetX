import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const NAVIGATOR_KEY = 1;
  static const INDEX_PAGE_EXIT = 2;

  final LoginService _loginService;

  HomeController({required LoginService loginService})
      : _loginService = loginService;

  final _pages = ['/movies', '/favorites'];

  final _pageIndex = 0.obs;

  int get pageIndex => _pageIndex.value;

  void goToPage(int page) {
    _pageIndex(page);

    if (page == INDEX_PAGE_EXIT) {
      _loginService.logout();
    }

    if (page == 1) {
      Get.offNamed('/favorites', id: NAVIGATOR_KEY);
    } else if (page == 0) {
      Get.offNamed('/movies', id: NAVIGATOR_KEY);
    }
  }
}
