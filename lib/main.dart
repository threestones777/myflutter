import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/language_provider.dart';
import './pages/home_page.dart';
import './pages/second_page.dart';
import './pages/photo.dart';
import './pages/html.dart';
import 'pages/video.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  var _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InTaroAdo',
      theme: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => SecondPage(),
        '/photo': (context) => ImagePickerWidget(),
        '/html': (context) {
          // 从路由参数中获取视频地址
          final arguments = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          final url = arguments?['url'] as String? ?? '';
          final title = arguments?['title'] as String? ?? '';
          return WebViewPage(title: title, url: url);
        },
        '/video': (context) {
          // 从路由参数中获取视频地址
          final arguments = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          final videoUrl = arguments?['videoUrl'] as String? ?? '';
          return MyVideoPlayer(videoUrl: videoUrl);
        },
      },
    );
  }
}
