import 'package:flutter/material.dart';

class TapableCard extends StatelessWidget {
  final Function onTap;
  final Text title;
  final Text subtitle;
  final Color color;
  final double elevation;
  final List<Widget> body;
  final MainAxisAlignment alignment;

  TapableCard(
      {@required this.onTap,
      @required this.title,
      this.subtitle,
      this.color,
      this.elevation,
      this.body,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        elevation: elevation,
        child: Column(
          children: [
            ListTile(
              title: title,
              subtitle: subtitle,
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: alignment ?? MainAxisAlignment.end,
                children: [...body ?? List()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
