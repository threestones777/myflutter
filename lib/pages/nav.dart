import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // 初始路由
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(), // 静态路由定义
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Details'),
          onPressed: () {
            // 路由跳转
            Navigator.pushNamed(context, '/details');
          },
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: ElevatedButton(
          child: Text('Back to Home'),
          onPressed: () {
            Navigator.pop(context); // 返回上一页
          },
        ),
      ),
    );
  }
}
