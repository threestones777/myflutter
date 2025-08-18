import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'pages/profile.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => HomePage(),
      profile: (context) => ProfilePage(),
    };
  }
}
