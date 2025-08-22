import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './index.dart';
import './listPage.dart';
import './recharge.dart';
import './profile.dart';
import 'language_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    final List<Widget> pages = [
      Index(),
      ListPage(),
      RechargeFormPage(),
      ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          'InTaroAdo',
          style: TextStyle(color: Color(0xFFc4f8e7)),
        ),
        backgroundColor: Color(0xFF1c3c31),
        actions: [
          Row(
            children: [
              Text(
                languageProvider.langs[languageProvider.selectedLang],
                style: TextStyle(color: Color(0xFFc4f8e7)),
              ),
              IconButton(
                icon: Icon(
                  Icons.language,
                  color: Color(0xFFffffff),
                ),
                onPressed: () {
                  _showShareDialog(context, languageProvider);
                },
              ),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(color: Colors.white, child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1c3c31),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '列表'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: '表单'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        selectedItemColor: Color(0xFFc4f8e7),
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1c3c31),
        child: Icon(
          Icons.settings,
          color: Color(0xFFc4f8e7),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/second');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1c3c31),
            ),
            child: Text(
              '菜单标题',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () {
              Navigator.pushNamed(context, '/second');
            },
          ),
          ListTile(
            leading: Icon(Icons.video_call),
            title: Text('视频'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/video',
                arguments: {
                  'videoUrl':
                      'https://cdn-www.huorong.cn/Public/Uploads/uploadfile/files/20240418/0418gongnengdianjihe.mp4',
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('退出'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showShareDialog(
      BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (context) {
        int tempSelectedIndex = languageProvider.selectedLang;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xFFffffff),
              title: Text(
                "选择语言",
                style: TextStyle(color: Color(0xFF1c3c31)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: languageProvider.langs.asMap().entries.map((entry) {
                  return RadioListTile<int>(
                    title: Text(
                      entry.value,
                      style: TextStyle(color: Color(0xFF1c3c31)),
                    ),
                    value: entry.key,
                    groupValue: tempSelectedIndex,
                    onChanged: (value) {
                      setState(() => tempSelectedIndex = value!);
                    },
                    activeColor: Color(0xFF1c3c31),
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "取消",
                    style: TextStyle(color: Color(0xFF1c3c31)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    languageProvider.changeLanguage(tempSelectedIndex);
                    Navigator.pop(context);
                  },
                  child: Text("确认", style: TextStyle(color: Color(0xFF1c3c31))),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
