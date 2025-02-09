import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    final cubit = context.read<AddressCubit>();
    cubit.fetchAddresses();
    super.initState();
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
          'العناوين',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<AddressCubit, AddressStates>(
          buildWhen: (previous, current) => current is FetchAddressesState,
          builder: (BuildContext context, state) {
            if (state is FetchAddressesState) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                itemBuilder: (BuildContext context, int index) {
                  return state.stateStatus == StateStatus.success
                      ? Container(
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
      ),
    );
  }
}
