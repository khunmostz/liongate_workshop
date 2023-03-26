import 'package:get/route_manager.dart';
import 'package:liongate_workshop/screens/auth.dart';
import 'package:liongate_workshop/screens/detail.dart';
import 'package:liongate_workshop/screens/home.dart';
import 'package:liongate_workshop/screens/qrcode.dart';

import 'screens/showround.dart';

class Routes {
  // static String initianScreen = '';
  List<GetPage> allScreens = [
    GetPage(name: '/auth', page: () => AuthScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/detail', page: () => DetailScreen()),
    GetPage(name: '/showround', page: () => RoundScreen()),
    GetPage(name: '/qrcode', page: () => QrcodeScreen()),
  ];
}
