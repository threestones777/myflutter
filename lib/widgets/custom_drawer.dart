import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const CustomDrawer({
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              '菜单标题',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('首页'),
            selected: currentIndex == 0,
            onTap: () => onItemSelected(0),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('搜索'),
            selected: currentIndex == 1,
            onTap: () => onItemSelected(1),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('个人中心'),
            selected: currentIndex == 2,
            onTap: () => onItemSelected(2),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () {
              Navigator.pop(context);
              // 可以添加导航到设置页的逻辑
            },
          ),
        ],
      ),
    );
  }
}
