import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:fort_parts/view/home_view/widgets/home_categories.dart';
import 'package:fort_parts/view/home_view/widgets/home_slider.dart';
import 'package:fort_parts/view/profile_view/address_screen.dart';
import 'package:get/get.dart';
import 'package:local_storage/local_storage.dart';
import 'package:location_services/location_services.dart';

import '../../constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final cubit = context.read<AddressCubit>();
    cubit.fetchAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topRight,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: Get.width * .2, height: Get.height * .1, child: Image.asset('images/logo.png')),
                    SizedBox(width: 10),
                    Container(
                      width: Get.width * .65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'مرحبا بك , ',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                              FutureBuilder(
                                  future: HiveHelper.get(hiveBox: HiveBoxes.user),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          AppNavigator.navigateTo(type: NavigationType.navigateTo, widget: SignInView());
                                        },
                                        child: Text(
                                          'انضم إلينا',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: mainColor),
                                        ),
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Text(
                                          "${snapshot.data.name} !",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                                        ),
                                        SizedBox(width: 4),
                                        Container(
                                            width: 35,
                                            height: 35,
                                            child: Image.asset(
                                              'icons/bye.png',
                                              fit: BoxFit.fill,
                                            )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FutureBuilder(
                            future: HiveHelper.get(hiveBox: HiveBoxes.user),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) return const SizedBox();
                              return InkWell(
                                onTap: () async {
                                  AppNavigator.navigateTo(type: NavigationType.navigateTo, widget: const AddressScreen());
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'العنوان : ',
                                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: mainColor),
                                    ),
                                    BlocBuilder<AddressCubit, AddressStates>(
                                      buildWhen: (previous, current) => current is FetchAddressesState,
                                      builder: (context, state) {
                                        if (state is FetchAddressesState) {
                                          return state.stateStatus == StateStatus.success && state.addresses.isNotEmpty
                                              ? FutureBuilder(
                                                  future: LocationServices.fetchFormattedAddress(
                                                      context: context,
                                                      latitude: double.parse(
                                                          state.addresses.firstWhere((element) => element.isDefault).latitude),
                                                      longitude: double.parse(
                                                          state.addresses.firstWhere((element) => element.isDefault).longitude)),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data == null) {
                                                      return SizedBox();
                                                    }
                                                    return Text(
                                                      snapshot.data!.subLocality ?? "",
                                                      style:
                                                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: mainColor),
                                                    );
                                                  },
                                                )
                                              : const SizedBox();
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: mainColor,
                                      size: 35,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Material(
                  elevation: .5,
                  shadowColor: Colors.grey,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 20, top: 5),
                      suffixIcon: Icon(
                        Icons.search,
                        color: mainColor,
                      ),
                      hintText: 'إبحث عن خدمة',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5)
                      // )
                    ),
                  ),
                ),
              ),
              const HomeSlider(),
              SizedBox(
                height: Get.height * .02,
              ),
              const HomeCategories(),
            ],
          ),
        ),
      ),
    );
  }
}
