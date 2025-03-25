import 'package:flutter/material.dart';
import 'package:adel_tarek/main.dart';
import 'package:adel_tarek/ui/common/modules/splash/splash_page.dart';
import 'package:adel_tarek/ui/modules/MainScreen/main_screen.dart';
import 'package:adel_tarek/utils/router/route_names.dart';

class RouteGenerator {
  RouteGenerator();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Route to: ${settings.name}');
    Root.routeName = settings.name ?? '';
    switch (settings.name) {
      case RouteNames.rSplashPage:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.rSplashPage),
          builder: (_) => const SplashPage(),
        );
      case RouteNames.rMainScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.rMainScreen),
          builder: (_) => const MainHomeScreen(),
        );

      /// ****************************default*********************************
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR')),
      );
    });
  }
}
