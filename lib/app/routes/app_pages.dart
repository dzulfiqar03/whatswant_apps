import 'package:get/get.dart';
import 'package:whatswant/contents/Launcher/launchBTN.dart';
import 'package:whatswant/contents/main_screen/home_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const INITIALS = Routes.HOMES;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => LaunchBtnPage(),
    ),
    GetPage(
      name: _Paths.HOMES,
      page: () => HomePage(),
    ),
  ];
}
