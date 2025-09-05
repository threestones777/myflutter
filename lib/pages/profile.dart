import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final List<Map<String, Object>> list = [
    {
      "url":
          "https://cdn-www.huorong.cn/Public/Uploads/uploadfile/files/20240418/0418gongnengdianjihe.mp4",
      "title": "Tailipai",
      "image":
          "https://cdn-www.huorong.cn/Public/Uploads/uploadfile/images/20240729/moshiqiehuan1.gif", // 添加图片URL
    },
    {
      "url":
          "https://cdn-www.huorong.cn/Public/Uploads/uploadfile/files/20240725/bannerdonghua.mp4",
      "title": "Detective Leuven",
      "image":
          "https://cdn-www.huorong.cn/Public/Uploads/uploadfile/images/20250729/qiyebanwebduanbeijing.png", // 添加图片URL
    },
    {
      "url":
          "https://image.uc.cn/s/uae/g/3o/broccoli/resource/202506/531ddfc18cb838cd.mp4",
      "title": "夸克",
      "image":
          "https://broccoli-static.quark.cn/file/others/2025/7/dec374c8e29d8f0be0f6c43a0eb6bd17.png",
    },
    {
      "url":
          "https://image.uc.cn/s/uae/g/3o/broccoli/resource/202505/5425daeae98d3cdc.mp4",
      "title": "AI",
      "image":
          "https://img.alicdn.com/imgextra/i2/O1CN01Nbhjt41FO3YRAMtcF_!!6000000000476-2-tps-440-364.png",
    },
    {
      "url":
          "https://image.uc.cn/s/uae/g/3o/broccoli/resource/202505/d2d2bd6c703a9c45.mp4",
      "title": "Product Four",
      "image":
          "https://www.anyviewer.cn/resource/images/home/av-home-part3-pic1@2x.jpg",
    },
  ];

  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity, // 宽度充满父容器
            height: 200,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://cdn-www.huorong.cn/Public/Uploads/uploadfile/images/20240229/i1bannerpc01.jpg'), // 使用网络图片
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8400),
                  offset: const Offset(0, 4.0),
                  blurRadius: 100.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset("assets/logo.jpg", width: 60.0),
                ),
                const SizedBox(height: 10),
                const Text('视频',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800)),
                const Text('阿斯UN搜没下来司机时代楷模那些',
                    style: TextStyle(color: Color(0xFFc4f8e7), fontSize: 12)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 16.0,
                    alignment: WrapAlignment.spaceBetween,
                    children: widget.list.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isOddIndex =
                          index % 2 == 0; // 0, 2, 4... 是奇数索引（从0开始）

                      return FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Padding(
                          padding: isOddIndex
                              ? const EdgeInsets.fromLTRB(
                                  16, 0, 8, 0) // 奇数项：左16右8
                              : const EdgeInsets.fromLTRB(
                                  8, 0, 16, 0), // 偶数项：左8右16
                          child: _buildProductCard(item, context),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // 构建产品卡片的方法
  Widget _buildProductCard(Map<String, Object> item, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/video',
          arguments: {
            'videoUrl': item['url'],
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品图片区域
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFf5f5f5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(item['image'] as String), // 使用动态图片URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 产品信息区域
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 品牌名称
                  Text(
                    item['title'] as String, // 使用动态标题
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // 可以添加更多信息
                  Text(
                    '点击查看详情',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
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
