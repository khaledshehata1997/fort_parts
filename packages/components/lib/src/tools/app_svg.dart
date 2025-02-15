import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSVG extends StatelessWidget {
  const AppSVG({
    required this.svgPath,
    required this.width,
    required this.height,
    super.key,
    this.color,
    this.fit = BoxFit.fill,
    this.matchTextDirection = true,
  });
  final String svgPath;
  final double width;
  final double height;
  final Color? color;
  final BoxFit fit;
  final bool matchTextDirection;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SvgPicture.asset(
        svgPath,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(
                color!,
                BlendMode.srcIn,
              )
            : null,
        fit: fit,
        matchTextDirection: matchTextDirection,
      ),
    );
  }
}
