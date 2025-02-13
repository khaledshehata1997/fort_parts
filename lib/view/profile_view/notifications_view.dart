import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:fort_parts/view/profile_view/coupons_view.dart';
import 'package:fort_parts/view/profile_view/warranty_details_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController scrollController = ScrollController();
  Meta? meta;
  bool hasMoreData = false;

  @override
  void initState() {
    final cubit = context.read<AuthenticationCubit>();
    cubit.refresh();
    cubit.fetchNotifications(
      currentPageIndex: 0,
    );

    // Pagination
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (meta!.totalPages > meta!.currentPage + 1) {
          setState(() {
            hasMoreData = true;
          });
          cubit.fetchNotifications(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'الإشعارات',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<AuthenticationCubit, AuthenticationStates>(
            buildWhen: (previous, current) => current is FetchNotificationsState,
            builder: (context, state) {
              if (state is FetchNotificationsState) {
                meta = state.meta;
                return Column(
                  children: [
                    ListView.separated(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return state.stateStatus == StateStatus.success
                            ? _buildNotificationItem(
                                time: state.notifications[index].time,
                                message: state.notifications[index].title,
                                number: (index + 1).toString(),
                                onTap: () {
                                  switch (state.notifications[index].type) {
                                    case 'coupon':
                                      return AppNavigator.navigateTo(
                                        type: NavigationType.navigateTo,
                                        widget: CouponsScreen(),
                                      );
                                    case 'order':
                                      return AppNavigator.navigateTo(
                                        type: NavigationType.navigateTo,
                                        widget: CouponsScreen(),
                                      );
                                    case 'task':
                                      return AppNavigator.navigateTo(
                                        type: NavigationType.navigateTo,
                                        widget: CouponsScreen(),
                                      );
                                    case 'certificate':
                                      return AppNavigator.navigateTo(
                                        type: NavigationType.navigateTo,
                                        widget: WarrantyDetailsScreen(
                                          certificateID: state.notifications[index].typeID,
                                        ),
                                      );
                                  }
                                },
                              )
                            : const SizedBox();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 16);
                      },
                      itemCount: state.stateStatus == StateStatus.success ? state.notifications.length : 2,
                    ),
                    if (hasMoreData)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: const CupertinoActivityIndicator(),
                      ),
                  ],
                );
              }
              return const SizedBox();
            },
          )),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        date,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String time,
    required String message,
    required String number,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.amber,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
