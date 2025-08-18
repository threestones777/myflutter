import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import './carousel.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];
  // 在_IndexState类中添加一个AnimationController
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Update the UI when tab changes
    });

    // 初始化动画控制器
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // 初始化淡入动画
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // 当切换到新闻标签时启动动画
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Header with logo, search, and favorite
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 10),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50.0,
                    child: Image.asset(
                      'assets/logo.jpg',
                      width: 45,
                      height: 45,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50.0,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        hintText: '请输入用户名',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        print('输入内容: $value');
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50.0,
                    child: Icon(Icons.favorite),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Carousel
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 10),
            child: CustomCarousel(),
          ),

          // Current language display
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("当前语言: ${languageProvider.selectedLang}"),
          ),

          // Tab bar
          TabBar(
            // 选中 Tab 的文字颜色
            labelColor: Color(0xFF1c3c31),
            // 未选中 Tab 的文字颜色
            unselectedLabelColor: Color(0xFF000000),
            // 底部指示器颜色
            indicatorColor: Color(0xFF1c3c31),
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),

          // Display the selected tab index
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("当前选中的Tab: ${tabs[_tabController.index]}"),
          ),

          // Tab content - using IndexedStack to maintain state
          SizedBox(
            height: 300, // 设置一个固定高度以确保内容可滚动
            child: IndexedStack(
              index: _tabController.index,
              children: [
                Center(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text("新闻内容", style: TextStyle(fontSize: 24)),
                  ),
                ),
                Center(child: Text("历史内容")),
                Center(child: Text("图片内容")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
