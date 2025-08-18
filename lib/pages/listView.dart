import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'package:dio/dio.dart';

class Lists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Column(
      children: <Widget>[
        //Flex的两个子widget按1：2来占据水平空间
        Table(
          border: TableBorder.all(), // 添加边框
          children: [
            TableRow(
              children: [
                TableCell(child: Text('姓名', textAlign: TextAlign.center)),
                TableCell(child: Text('年龄', textAlign: TextAlign.center)),
                TableCell(child: Text('职业', textAlign: TextAlign.center)),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('张三')),
                TableCell(child: Text('28')),
                TableCell(child: Text('工程师')),
              ],
            ),
            TableRow(
              children: [
                TableCell(child: Text('李四')),
                TableCell(child: Text('32')),
                TableCell(child: Text('设计师')),
              ],
            ),
          ],
        ),
        DataTable(
          columns: [
            DataColumn(label: Text('姓名')),
            DataColumn(label: Text('年龄')),
            DataColumn(label: Text('职业')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('张三')),
              DataCell(Text('28')),
              DataCell(Text('工程师')),
            ]),
            DataRow(cells: [
              DataCell(Text('李四')),
              DataCell(Text('32')),
              DataCell(Text('设计师')),
            ]),
          ],
        ),
        Column(
          children: [
            // 表头
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                      flex: 2, child: Text('姓名', textAlign: TextAlign.left)),
                  Expanded(child: Text('年龄', textAlign: TextAlign.left)),
                  Expanded(
                      flex: 4, child: Text('职业', textAlign: TextAlign.left)),
                ],
              ),
            ),
            // 表格内容
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: Text(index == 0 ? '张三' : '李四')),
                      Expanded(child: Text(index == 0 ? '28' : '32')),
                      Expanded(
                          flex: 4, child: Text(index == 0 ? '工程师' : '设计师')),
                    ],
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
