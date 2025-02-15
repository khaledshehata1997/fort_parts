import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/view/requests_view/widgets/cancel_warning_dialog.dart';
import 'package:hexcolor/hexcolor.dart';

class ProviderDetailsBottomSheet extends StatelessWidget {
  const ProviderDetailsBottomSheet({
    super.key,
    required this.task,
    required this.index,
    required this.orderID,
  });

  final Task task;
  final int index;
  final int orderID;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: 375.w,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  AppSVG(
                    svgPath: AppImages.setting,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 10.w),
                  AppText(
                    text: "مهمة",
                    color: Color(0xFF333333),
                    textStyles: AppTextStyles.regular16,
                  ),
                  SizedBox(width: 5.w),
                  AppText(
                    text: (index + 1).toString(),
                    color: Color(0xFF333333),
                    textStyles: AppTextStyles.regular16,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.fE0AA06,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              OrderInfoRow(
                icon: AppImages.hash,
                label: "المهمة:",
                value: task.product.name,
              ),
              SizedBox(height: 20.h),
              OrderInfoRow(
                icon: AppImages.technical,
                label: "الفني:",
                value: task.provider.name,
              ),
              SizedBox(height: 20.h),
              OrderInfoRow(
                icon: AppImages.calendar,
                label: "تاريخ التنفيذ:",
                value: task.date,
              ),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSVG(
                    svgPath: AppImages.status,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 10.w),
                  AppText(
                    text: "حالة الطلب :",
                    color: Color(0xFF333333),
                    textStyles: AppTextStyles.regular16,
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: HexColor(task.statusColor),
                  ),
                  SizedBox(width: 10.w),
                  AppText(
                    text: task.status,
                    color: HexColor(task.statusColor),
                    textStyles: AppTextStyles.bold16,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              OrderInfoRow(
                icon: AppImages.notes,
                label: "ملاحظات أخرى:",
                value: task.notes,
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.fE0AA06,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSVG(
                              svgPath: AppImages.back,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 10.w),
                            AppText(
                              text: "العودة لقائمة المهام",
                              color: Color(0xFF333333),
                              textStyles: AppTextStyles.regular14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.r),
                      onTap: () async {
                        await showCancelWarningDialog(
                          context: context,
                          taskID: task.id,
                          orderID: orderID,
                        );
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color(0xFFAD0000),
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSVG(
                              svgPath: AppImages.cancel,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(width: 5.w),
                            AppText(
                              text: "إلغاء المهمة",
                              color: Color(0xFFAD0000),
                              textStyles: AppTextStyles.bold16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderInfoRow extends StatelessWidget {
  const OrderInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSVG(
          svgPath: icon,
          width: 24,
          height: 24,
        ),
        SizedBox(width: 10.w),
        AppText(
          text: label,
          color: Color(0xFF333333),
          textStyles: AppTextStyles.regular16,
        ),
        SizedBox(width: 10.w),
        AppText(
          text: value,
          color: Color(0xFF333333),
          textStyles: AppTextStyles.bold16,
        ),
      ],
    );
  }
}
