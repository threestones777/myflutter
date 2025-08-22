import 'package:flutter/material.dart';

/// 顶部搜索框组件，带文字轮播效果，可切换为真实搜索框
class SearchInput extends StatefulWidget {
  /// 输入框内滚动内容
  final List<String> titles = [
    '浓眉哥拒绝湖人续约 | 武汉通报肺炎事件',
    '伊朗或有第三轮袭击 | 大众cc老款图片',
    '苹果呼吸灯怎么设置 | 红旗H9全球首秀',
    '武汉肺炎事件后续 | 沃尔沃xc70图片',
    '北京户口申请条件 | 红旗H9汽车',
    '武汉新型冠状病毒 | 马刺'
  ];

  @override
  State<StatefulWidget> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 800);
  static const _carouselDelay = Duration(seconds: 3);

  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupFocusListener();

    // 启动首次轮播延迟
    // _startCarouselWithDelay();
    _animationController.forward();
  }

  /// 设置动画相关配置
  void _setupAnimations() {
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener(_handleAnimationStatus);

    // 定义淡入淡出动画
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  /// 设置焦点监听器
  void _setupFocusListener() {
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
        _exitSearchMode();
      }
    });
  }

  /// 处理动画状态变化
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_isSearchActive) {
      Future.delayed(_carouselDelay, () {
        if (mounted) {
          _animationController.reverse().then((_) {
            if (mounted) {
              setState(() => _currentIndex++);
              _animationController.forward();
            }
          });
        }
      });
    }
  }

  /// 延迟启动轮播
  void _startCarouselWithDelay() {
    Future.delayed(_carouselDelay, () {
      if (mounted && !_isSearchActive) {
        _animationController.forward();
      }
    });
  }

  /// 激活搜索模式
  void _activateSearch() {
    setState(() => _isSearchActive = true);
    FocusScope.of(context).requestFocus(_searchFocusNode);
  }

  /// 退出搜索模式
  void _exitSearchMode() {
    setState(() {
      _isSearchActive = false;
      _searchController.clear();
    });
    _searchFocusNode.unfocus();
    _restartCarousel();
  }

  /// 重新启动轮播
  void _restartCarousel() {
    _animationController.reset();
    _animationController.forward();
  }

  /// 执行搜索操作
  void _performSearch(String keyword) {
    if (keyword.isNotEmpty) {
      print('正在搜索: $keyword');
      // 实际搜索逻辑
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSearchActive ? _buildActiveSearchBox() : _buildPreviewSearchBox();
  }

  /// 构建预览状态的搜索框（带轮播效果）
  Widget _buildPreviewSearchBox() {
    return GestureDetector(
      onTap: _activateSearch,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(Icons.search, color: Colors.grey[600], size: 20),
            const SizedBox(width: 8),
            Expanded(child: _buildAnimatedTitle()),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  /// 构建激活状态的搜索框（真实输入框）
  Widget _buildActiveSearchBox() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue, width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: const InputDecoration(
                hintText: '请输入搜索内容...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 16),
              autofocus: true,
              onSubmitted: _performSearch,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear, size: 20),
            onPressed: _exitSearchMode,
            padding: const EdgeInsets.all(4),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  /// 构建动画标题（淡入淡出效果）
  Widget _buildAnimatedTitle() {
    final title = widget.titles[_currentIndex % widget.titles.length];

    return Opacity(
      opacity: _fadeAnimation.value,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
