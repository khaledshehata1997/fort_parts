import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    required this.text,
    required this.color,
    required this.textStyles,
    super.key,
    this.height = 1.0,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.center,
    this.maxLines,
  });
  final String text;
  final Color color;
  final TextStyle textStyles;
  final double height;
  final TextDecoration? textDecoration;
  final TextAlign textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: textStyles.copyWith(
        color: color,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}
