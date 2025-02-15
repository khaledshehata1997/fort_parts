import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';

Future<dynamic> showCancelWarningDialog({
  required BuildContext context,
  required int taskID,
  required int orderID,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9.r),
          ),
        ),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: 350.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 25.h),
                Text(
                  "هل أنت متأكد من رغبتك في",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  " إنهاء المهمة؟",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 20.w),
                AppSVG(
                  svgPath: AppImages.warning,
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 20.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      BlocListener<OrderCubit, OrderStates>(
                        listenWhen: (previous, current) => current is CancelTaskState,
                        listener: (context, state) {
                          if (state is CancelTaskState && state.stateStatus == StateStatus.success) {
                            final cubit = context.read<OrderCubit>();
                            cubit.fetchOrder(orderID: orderID);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () async {
                              final cubit = context.read<OrderCubit>();
                              await cubit.cancelTask(taskID: taskID);
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: AppColors.fE0AA06,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: AppText(
                                  text: "نعم، إلغاء المهمة",
                                  color: Color(0xFF333333),
                                  textStyles: AppTextStyles.regular14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Color(0xFF333333),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: AppText(
                                text: " العودة، للاستكمال!",
                                color: Color(0xFF333333),
                                textStyles: AppTextStyles.regular16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.w),
              ],
            ),
          ),
        ),
      );
    },
  );
}
