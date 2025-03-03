import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';
import 'package:fort_parts/view/requests_view/request_details_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  final ScrollController scrollController = ScrollController();
  Meta? meta;
  bool hasMoreData = false;

  @override
  void initState() {
    final cubit = context.read<OrderCubit>();
    cubit.refresh();
    cubit.fetchOrders(currentPageIndex: 1);

    // Pagination
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (meta!.totalPages > meta!.currentPage + 1) {
          setState(() {
            hasMoreData = true;
          });
          cubit.fetchOrders(
            currentPageIndex: meta!.currentPage + 1,
          );
        } else {
          setState(() {
            hasMoreData = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('requests'.tr, style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderCubit, OrderStates>(
        buildWhen: (previous, current) => current is FetchOrdersState,
        builder: (context, state) {
          if (state is FetchOrdersState) {
            meta = state.meta;
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    itemBuilder: (BuildContext context, int index) {
                      return state.stateStatus == StateStatus.success
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(width: 1.0, color: Color(0xFFF6F4FA).withValues(alpha: 0.80)),
                              ),
                              child: Column(
                                children: [
                                  OrderInfoRow(
                                    icon: AppImages.hash,
                                    label: "requestNo".tr,
                                    value: state.orders[index].id.toString(),
                                  ),
                                  SizedBox(height: 16.h),
                                  OrderInfoRow(
                                    icon: AppImages.task1,
                                    label: "taskNo".tr,
                                    value: state.orders[index].tasksCount.toString(),
                                  ),
                                  SizedBox(height: 16.h),
                                  OrderInfoRow(
                                    icon: AppImages.calendar,
                                    label: "firstVisitDate".tr,
                                    value: state.orders[index].date,
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
                                        backgroundColor: HexColor(state.orders[index].statusColor),
                                      ),
                                      SizedBox(width: 10.w),
                                      AppText(
                                        text: state.orders[index].status,
                                        color: HexColor(state.orders[index].statusColor),
                                        textStyles: AppTextStyles.bold16,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(12.r),
                                    onTap: () {
                                      AppNavigator.navigateTo(
                                        type: NavigationType.navigateTo,
                                        widget: RequestDetailsView(orderID: state.orders[index].id),
                                      );
                                    },
                                    child: Container(
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(width: 1.0, color: Color(0xFFE0AA06)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          AppSVG(
                                            svgPath: AppImages.view,
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 10.w),
                                          AppText(
                                            text: "reviewDetails".tr,
                                            color: Color(0xFFE0AA06),
                                            textStyles: AppTextStyles.regular18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : AppShimmer(
                              child: Container(
                              width: 375.h,
                              height: 300.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16);
                    },
                    itemCount: state.stateStatus == StateStatus.success ? state.orders.length : 2,
                  ),
                ),
                if (hasMoreData)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: const CupertinoActivityIndicator(),
                  ),
                SizedBox(height: 100.h),
              ],
            );
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
