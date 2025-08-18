import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Dio _dio = Dio();
  bool _isLoading = false;
  List _data = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = await _dio.get(
          'https://api.github.com/search/users?q=threestones&per_page=100');
      setState(() {
        _data = response.data['items'];
      });
    } catch (e) {
      setState(() {
        _error = '加载失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('详情页')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _loadData,
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(child: Text(_error));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        // 表头
        SizedBox(
          height: 50.0,
          child: Container(
            color: Color(0xFF98c0c9),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('ID', textAlign: TextAlign.left)),
                Expanded(flex: 4, child: Text('姓名', textAlign: TextAlign.left)),
                Expanded(
                    flex: 2, child: Text('地址', textAlign: TextAlign.center)),
              ],
            ),
          ),
        ),
        ..._data.map((item) {
          return SizedBox(
            height: 40.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // 垂直居中
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Text(
                      item['id'].toString(),
                    )),
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text(item['login']),
                              leading: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            body: Center(
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadius.circular(70), // 设置圆角
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item['avatar_url'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(item['login']),
                  ),
                ),
                Expanded(
                  flex: 2,
                  // child: Text(item['html_url'], textAlign: TextAlign.center),
                  child: TextButton(
                    onPressed: () async {
                      var url = item['html_url'];
                      // var url = 'tel:+123456789';
                      // var url = 'sms:+123456789';
                      // var url = 'mailto:info@example.com';
                      try {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(
                            Uri.parse(url),
                            mode: LaunchMode.externalApplication, // 使用外部浏览器打开
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('无法打开链接')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('发生错误: $e')),
                        );
                      }
                    },
                    child: Text('去看看'),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ]),
    );
  }
}
