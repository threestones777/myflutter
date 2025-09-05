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
            icon: Icon(Icons.reply_all, color: Colors.white), //自定义图标
            onPressed: () {
              Navigator.pop(context); //返回
            },
          );
        }),
        title: Text(
          '设置',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity, // 宽度100%
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/vip.jpeg'), // 本地图片
                  fit: BoxFit.cover, // 图片填充方式
                ),
              ),
              child: Center(
                  child: Text('王振磊',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 36))),
            ),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text('常用功能', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildFuncItem(Icons.hearing, '关注'),
                      _buildFuncItem(Icons.notifications_none, '消息通知'),
                      _buildFuncItem(Icons.star_border, '收藏'),
                      _buildFuncItem(Icons.history, '阅读历史'),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildFuncItem(Icons.hearing, '关注'),
                      _buildFuncItem(Icons.notifications_none, '消息通知'),
                      _buildFuncItem(Icons.star_border, '收藏'),
                      _buildFuncItem(Icons.history, '阅读历史'),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      '更多功能',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Table(
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        _buildFuncItem(Icons.memory, '超级会员'),
                        _buildFuncItem(Icons.public, '圆梦公益'),
                        _buildFuncItem(Icons.merge_type, '夜间模式'),
                        _buildFuncItem(Icons.comment, '评论'),
                      ]),
                      TableRow(children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ]),
                      TableRow(children: <Widget>[
                        _buildFuncItem(Icons.favorite_border, '点赞'),
                        _buildFuncItem(Icons.scanner, '扫一扫'),
                        _buildFuncItem(Icons.fingerprint, '广告推广'),
                        Container(),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFuncItem(IconData iconData, String txt) {
  return Container(
    child: Column(
      children: <Widget>[
        Icon(
          iconData,
          size: 30,
        ),
        Text(txt)
      ],
    ),
  );
}
