import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 16.0,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/html',
                            arguments: {
                              'title': 'Dart 模版',
                              'url': "https://share.note.youdao.com/s/4yjjzrre",
                            },
                          );
                        },
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            height: 30.0,
                            color: Colors.blue,
                            child: Center(child: Text('Dart 模版')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
