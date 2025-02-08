import 'package:components/components.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.title,
    super.key,
  });

  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: title == null,
      appBar: title != null
          ? AppBar(
              title: AppText(
                text: title!,
                color: AppColors.f121256,
                textStyles: AppTextStyles.medium18,
              ),
            )
          : null,
      body: body,
    );
  }
}
