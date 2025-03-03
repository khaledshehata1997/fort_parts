import 'package:components/components.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';
import 'package:fort_parts/view/requests_view/widgets/provider_details_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class RequestDetailsView extends StatefulWidget {
  const RequestDetailsView({
    super.key,
    required this.orderID,
  });

  final int orderID;

  @override
  State<RequestDetailsView> createState() => _RequestDetailsViewState();
}

class _RequestDetailsViewState extends State<RequestDetailsView> {
  @override
  void initState() {
    final cubit = context.read<OrderCubit>();
    cubit.fetchOrder(orderID: widget.orderID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('requestDetails'.tr, style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderCubit, OrderStates>(
        buildWhen: (previous, current) => current is FetchOrderState,
        builder: (context, state) {
          if (state is FetchOrderState) {
            return state.stateStatus == StateStatus.success
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(width: 1.0, color: Color(0xFFF6F4FA).withValues(alpha: 0.80)),
                          ),
                          child: Column(
                            children: [
                              OrderInfoRow(
                                icon: AppImages.hash,
                                label: "requestNo".tr,
                                value: state.order!.id.toString(),
                              ),
                              SizedBox(height: 16.h),
                              OrderInfoRow(
                                icon: AppImages.setting,
                                label: "serviceName".tr,
                                value: state.order!.products[0].name,
                              ),
                              SizedBox(height: 16.h),
                              OrderInfoRow(
                                icon: AppImages.calendar,
                                label: "firstVisitDate".tr,
                                value: state.order!.date,
                              ),
                              SizedBox(height: 16.h),
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
                                    text: "statusRequest".tr,
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.regular16,
                                  ),
                                  SizedBox(width: 10.w),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: HexColor(state.order!.statusColor),
                                  ),
                                  SizedBox(width: 10.w),
                                  AppText(
                                    text: state.order!.status,
                                    color: HexColor(state.order!.statusColor),
                                    textStyles: AppTextStyles.bold16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          width: 390.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ExpandablePanel(
                            theme: ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              iconColor: AppColors.fE0AA06,
                            ),
                            header: SizedBox(
                              height: 60.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppSVG(
                                    svgPath: AppImages.task2,
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "tasksList".tr,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            collapsed: const SizedBox(),
                            expanded: state.order!.tasks.isNotEmpty
                                ? GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                    padding: EdgeInsetsDirectional.only(bottom: 20.h),
                                    childAspectRatio: 3.5 / 1,
                                    children: List.generate(
                                      state.order!.tasks.length,
                                      (index) => InkWell(
                                        borderRadius: BorderRadius.circular(8.r),
                                        onTap: () {
                                          showModalBottomSheet(
                                            elevation: 0.0,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) => ProviderDetailsBottomSheet(
                                              task: state.order!.tasks[index],
                                              index: index,
                                              orderID: state.order!.id,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.r),
                                            border: Border.all(width: 1.0, color: AppColors.fE0AA06),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              AppSVG(
                                                svgPath: AppImages.task3,
                                                width: 16,
                                                height: 16,
                                              ),
                                              SizedBox(width: 10.h),
                                              AppText(
                                                text: "task".tr,
                                                color: Color(0xFF333333),
                                                textStyles: AppTextStyles.regular14,
                                              ),
                                              SizedBox(width: 5.h),
                                              AppText(
                                                text: (index + 1).toString(),
                                                color: Color(0xFF333333),
                                                textStyles: AppTextStyles.regular14,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                : Padding(
                                    padding: EdgeInsetsDirectional.only(bottom: 10.h),
                                    child: Center(
                                      child: AppText(
                                        text: "thereIsNoTasks".tr,
                                        color: Color(0xFF333333),
                                        textStyles: AppTextStyles.regular14,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          width: 390.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ExpandablePanel(
                            theme: ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              iconColor: AppColors.fE0AA06,
                            ),
                            header: SizedBox(
                              height: 60.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppSVG(
                                    svgPath: AppImages.spare,
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "addedSpareParts".tr,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            collapsed: const SizedBox(),
                            expanded: state.order!.spareParts.isNotEmpty
                                ? ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsetsDirectional.only(bottom: 20.h),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 4.r,
                                                  backgroundColor: Color(0xFF333333),
                                                ),
                                                SizedBox(width: 5.w),
                                                AppText(
                                                  text: state.order!.spareParts[index].name,
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1.0,
                                            height: 20.h,
                                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                                            decoration: BoxDecoration(color: Color(0xFFDFDFDF)),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                AppText(
                                                  text: "quantity".tr,
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                                SizedBox(width: 5.w),
                                                AppText(
                                                  text: state.order!.spareParts[index].quantity.toString(),
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1.0,
                                            height: 20.h,
                                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                                            decoration: BoxDecoration(color: Color(0xFFDFDFDF)),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                AppText(
                                                  text: state.order!.spareParts[index].price.toString(),
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                                SizedBox(width: 5.w),
                                                AppText(
                                                  text: "SAR".tr,
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 1.0,
                                            height: 20.h,
                                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                                            decoration: BoxDecoration(color: Color(0xFFDFDFDF)),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                AppText(
                                                  text: "total".tr,
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                                SizedBox(width: 5.w),
                                                AppText(
                                                  text: state.order!.spareParts[index].total.toString(),
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                                SizedBox(width: 5.w),
                                                AppText(
                                                  text: "SAR".tr,
                                                  color: Color(0xFF333333),
                                                  textStyles: AppTextStyles.regular12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(height: 20.h);
                                    },
                                    itemCount: state.order!.spareParts.length,
                                  )
                                : Padding(
                                    padding: EdgeInsetsDirectional.only(bottom: 10.h),
                                    child: Center(
                                      child: AppText(
                                        text: "thereIsNoSpareParts".tr,
                                        color: Color(0xFF333333),
                                        textStyles: AppTextStyles.regular14,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                          width: 390.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  AppText(
                                    text: "totalServiceCost".tr,
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.regular16,
                                  ),
                                  SizedBox(width: 10.w),
                                  AppText(
                                    text: "${state.order!.subTotal} ر.س",
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.bold16,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  AppText(
                                    text: "totalSparePartsCost".tr,
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.regular16,
                                  ),
                                  SizedBox(width: 10.w),
                                  AppText(
                                    text: "${state.order!.sparePrice} ر.س",
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.bold16,
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20.h),
                                height: 1,
                                color: AppColors.fE0AA06,
                              ),
                              Row(
                                children: [
                                  AppSVG(svgPath: AppImages.total, width: 24, height: 24),
                                  SizedBox(width: 10.w),
                                  AppText(
                                    text: "الإجمالي: ${state.order!.total} ريال فقط لا غير ",
                                    color: Color(0xFF333333),
                                    textStyles: AppTextStyles.bold16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox();
          }
          return const SizedBox();
        },
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
