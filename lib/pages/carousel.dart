import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatefulWidget {
  @override
  _CustomCarouselDemoState createState() => _CustomCarouselDemoState();
}

class _CustomCarouselDemoState extends State<CustomCarousel> {
  int _current = 0;
  final List<Widget> customItems = [
    _buildCustomCard(
      title: "Flutter开发",
      subtitle: "跨平台应用开发框架",
      color: Colors.blue,
      icon: Icons.code,
    ),
    _buildCustomCard(
      title: "Dart语言",
      subtitle: "面向对象的编程语言",
      color: Colors.green,
      icon: Icons.language,
    ),
    _buildCustomCard(
      title: "UI设计",
      subtitle: "美观的用户界面",
      color: Colors.orange,
      icon: Icons.design_services,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: customItems,
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: customItems.asMap().entries.map((entry) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == entry.key ? Colors.blueAccent : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  static Widget _buildCustomCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            Colors.blue,
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFc4f8e7),
            blurRadius: 8.0,
            spreadRadius: 7.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.white),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
