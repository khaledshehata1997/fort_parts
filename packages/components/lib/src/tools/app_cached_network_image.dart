import 'package:cached_network_image/cached_network_image.dart';
import 'package:components/src/styles/app_colors.dart';
import 'package:components/src/tools/app_shimmer.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    required this.imageUrl,
    required this.height,
    required this.width,
    this.radius = 0,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (BuildContext context, String imageUrl) {
          return AppShimmer(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: AppColors.fffffff,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          );
        },
        errorWidget: (BuildContext context, String imageUrl, dynamic error) {
          return Image.asset(
            "",
            height: height,
            width: width,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
