import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AppAnimatedDropDown extends StatefulWidget {
  const AppAnimatedDropDown({
    required this.scrollController,
    required this.width,
    required this.height,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.icon = '',
    this.iconColor = AppColors.f999999,
    this.color,
    super.key,
  });

  final ScrollController scrollController;
  final double width;
  final double height;
  final String hint;
  final String? value;
  final List<String> items;
  final Function onChanged;
  final String icon;
  final Color iconColor;
  final Color? color;

  @override
  State<AppAnimatedDropDown> createState() => _AppAnimatedDropDownState();
}

class _AppAnimatedDropDownState extends State<AppAnimatedDropDown> with TickerProviderStateMixin {
  late final AnimationController expandController;
  late final AnimationController iconController;
  late final Animation<double> animation;
  final Tween<double> turnsTween = Tween<double>(begin: 1, end: 0.5);
  bool isExpanding = false;
  bool isScrolled = false;

  updateShowDropDown() async {
    if (expandController.value == 1.0) {
      expandController.reverse();
      iconController.reverse();
      isScrolled = false;
      setState(() {
        isExpanding = false;
        isScrolled = false;
      });
    } else {
      setState(() {
        isExpanding = true;
      });
      expandController.forward();
      iconController.forward();
    }
  }

  @override
  void initState() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );

    super.initState();
  }

  @override
  void dispose() {
    expandController.dispose();
    iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            updateShowDropDown();
          },
          child: Container(
            padding: const EdgeInsetsDirectional.only(start: 16, end: 5),
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.fffffff,
              borderRadius: BorderRadius.circular(5),
              boxShadow: isExpanding ? [AppShadows.shadow1] : const [],
              border: Border.all(
                width: 1.0,
                color: widget.color ?? AppColors.f000000.withOpacity(0.24),
              ),
            ),
            child: Row(
              children: [
                if (widget.icon.isNotEmpty) ...[
                  AppSVG(
                    svgPath: widget.icon,
                    width: 24,
                    height: 24,
                    color: widget.iconColor,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    widget.value ?? widget.hint,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      color: widget.value != null
                          ? widget.color ?? AppColors.f151522
                          : AppColors.f151522.withOpacity(0.4),
                      fontWeight: widget.value != null ? FontWeight.w400 : FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                RotationTransition(
                  turns: turnsTween.animate(iconController),
                  child: AppSVG(
                    svgPath: "packages/components/assets/images/arrow_down_ios.svg",
                    width: 24,
                    height: 24,
                    color: widget.color ?? AppColors.f999999,
                  ),
                ),
              ],
            ),
          ),
        ),
        VisibilityDetector(
          key: const Key('key'),
          onVisibilityChanged: (VisibilityInfo info) {
            if (!isScrolled && info.visibleFraction > 0.0 && info.visibleFraction < 1.0) {
              isScrolled = true;
              widget.scrollController.animateTo(
                widget.scrollController.offset + ((1.0 - info.visibleFraction) * 250),
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            }
          },
          child: SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              children: [
                const SizedBox(height: 14),
                Container(
                  width: widget.width,
                  height: widget.items.length > 2 ? 200 : (widget.items.length * 60),
                  decoration: BoxDecoration(
                    color: AppColors.fffffff,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [AppShadows.shadow2],
                    border: Border.all(
                      width: 1.0,
                      color: AppColors.f000000.withOpacity(0.24),
                    ),
                  ),
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          widget.onChanged(widget.items[index]);
                          updateShowDropDown();
                        },
                        child: Text(
                          widget.items[index],
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.f151522.withOpacity(0.72),
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 1,
                        color: AppColors.fE4E4E4.withOpacity(0.4),
                        height: 32,
                      );
                    },
                    itemCount: widget.items.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
