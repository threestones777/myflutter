import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url; // 添加url参数
  final String title; // 添加title参数

  WebViewPage({required this.url, required this.title}); // 构造函数接收url和title

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // 使用从路由传入的url

    setState(() {
      _controller = controller;
      _isControllerInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1c3c31),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.reply_all, color: Colors.white), //自定义图标
            onPressed: () {
              Navigator.pop(context); //返回
            },
          );
        }),
        title: Text(
          widget.title, // 使用从路由传入的title
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          if (_isControllerInitialized && _controller != null)
            WebViewWidget(controller: _controller!)
          else
            Center(child: CircularProgressIndicator()),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
