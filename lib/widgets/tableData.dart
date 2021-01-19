import 'package:flutter/material.dart';

class TableData extends StatelessWidget {
  final List<TableRow> rows;
  final List<Text> head;

  TableData({@required this.rows, this.head});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.green, style: BorderStyle.solid)),
      children: [
        TableRow(
          children: head.map((element) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4), 
              child: element
            );
          }).toList(),
          decoration: BoxDecoration(
            color: Colors.green[200],
          ),
        ),
        ...rows
      ],
    );
  }
}
