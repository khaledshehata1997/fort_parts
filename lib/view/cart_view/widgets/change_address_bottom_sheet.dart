import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';

class ChangeAddressBottomSheet extends StatefulWidget {
  const ChangeAddressBottomSheet({super.key});

  @override
  State<ChangeAddressBottomSheet> createState() => _ChangeAddressBottomSheetState();
}

class _ChangeAddressBottomSheetState extends State<ChangeAddressBottomSheet> {
  @override
  void initState() {
    final cubit = context.read<AddressCubit>();
    cubit.fetchAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
            BlocBuilder<AddressCubit, AddressStates>(
              buildWhen: (previous, current) => current is FetchAddressesState,
              builder: (BuildContext context, state) {
                if (state is FetchAddressesState) {
                  return ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                    itemBuilder: (BuildContext context, int index) {
                      return state.stateStatus == StateStatus.success
                          ? InkWell(
                              onTap: () => Navigator.pop(context, state.addresses[index]),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    AppSVG(
                                      svgPath: AppImages.home,
                                      width: 24,
                                      height: 24,
                                      color: AppColors.fE0AA06,
                                    ),
                                    SizedBox(width: 16.w),
                                    AppText(
                                      text: "${state.addresses[index].name}: ${state.addresses[index].address}",
                                      color: AppColors.f121256,
                                      textStyles: AppTextStyles.regular16,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : AppShimmer(
                              child: Container(
                                width: 343.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16.h);
                    },
                    itemCount: state.stateStatus == StateStatus.success ? state.addresses.length : 3,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
