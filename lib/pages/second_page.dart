import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1c3c31),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.backspace, color: Colors.white), //自定义图标
            onPressed: () {
              Navigator.pop(context); //返回
            },
          );
        }),
        title: Text(
          '第二个页面',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // width: double.infinity, // 宽度撑满父容器
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity, // 宽度100%
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/vip.webp'), // 本地图片
                  // image: NetworkImage('https://example.com/image.jpg'), // 网络图片
                  fit: BoxFit.cover, // 图片填充方式
                ),
              ),
              child: Text('内容文字', style: TextStyle(color: Colors.white)),
            ),
            Icon(Icons.home),
            ClipRRect(
              borderRadius: BorderRadius.circular(100), // 圆角半径
              child: Image.asset(
                'assets/1.png',
                width: 70,
                height: 70,
                fit: BoxFit.cover, // 填充方式
              ),
            ),
            SizedBox(height: 20),
            Text('这是通过路由跳转过来的页面'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('下载'),
              onPressed: () async {
                try {
                  // GET 请求示例
                  final response = await dio.get(
                    'https://jsonplaceholder.typicode.com/posts/1',
                  );
                  print(response.data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('请求成功: ${response.data}'),
                      action: SnackBarAction(
                        label: '撤销',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    ),
                  );
                } on DioException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('请求失败: ${e.message}')),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
