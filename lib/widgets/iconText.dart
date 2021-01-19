import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Text text;
  final Icon icon;
  final TextDirection textDirection;

  IconText({@required this.text, @required this.icon, this.textDirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: textDirection ?? TextDirection.rtl,
        children: [text, icon],
      ),
    );
  }
}
