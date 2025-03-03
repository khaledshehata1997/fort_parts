import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/view/auth/sign_in_view.dart';
import 'package:fort_parts/view/profile_view/address_screen.dart';
import 'package:fort_parts/view/profile_view/coupons_view.dart';
import 'package:fort_parts/view/profile_view/lang/cubit/lang_cubit.dart';
import 'package:fort_parts/view/profile_view/lang/cubit/lang_state.dart';
import 'package:fort_parts/view/profile_view/notifications_view.dart';
import 'package:fort_parts/view/profile_view/profile_info_screen.dart';
import 'package:fort_parts/view/profile_view/terms_conditions_view.dart';
import 'package:fort_parts/view/profile_view/warranty_documents_view.dart';
import 'package:get/get.dart';
import 'package:local_storage/local_storage.dart';

import '../../translations/helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _language = true;
  void checkLanguage(){
    if(Helper.getCurrentLocal() == 'AR'){
      setState(() {
        _language = false;
      });
    } else {
      setState(() {
        _language = true;
      });
    }
  }
  @override
  void initState() {
    checkLanguage();
    final cubit = context.read<AuthenticationCubit>();
    cubit.fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          'profile'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E7),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profile Image and Edit Icon
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Center(
                        child: FutureBuilder(
                          future: HiveHelper.get(hiveBox: HiveBoxes.user),
                          builder: (BuildContext context, snapshot) {
                            return snapshot.data != null
                                ? AppCachedNetworkImage(
                                    imageUrl: snapshot.data.image,
                                    height: 80,
                                    width: 80,
                                    radius: 100,
                                  )
                                : SizedBox();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavigator.navigateTo(
                            type: NavigationType.navigateTo,
                            widget: PersonalInfoScreen(),
                          ).then((_) => setState(() {}));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Name
                  FutureBuilder(
                    future: HiveHelper.get(hiveBox: HiveBoxes.user),
                    builder: (BuildContext context, snapshot) {
                      return snapshot.data != null
                          ? Text(
                              snapshot.data.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : SizedBox();
                    },
                  ),

                  const SizedBox(height: 12),
                  // Stats
                  FutureBuilder(
                    future: HiveHelper.get(hiveBox: HiveBoxes.user),
                    builder: (BuildContext context, snapshot) {
                      return snapshot.data != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStat(
                                  'active'.tr,
                                  snapshot.data.pos.toString(),
                                ),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey[300],
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                                _buildStat(
                                  'used'.tr,
                                  snapshot.data.posUsed.toString(),
                                ),
                              ],
                            )
                          : SizedBox();
                    },
                  ),
                ],
              ),
            ),
            // Menu Items
            GestureDetector(
                onTap: () {
                  Get.to(const NotificationsScreen());
                },
                child: _buildMenuItem(Icons.notifications_outlined, 'notification'.tr)),
            GestureDetector(
                onTap: () {
                  Get.to(const CouponsScreen());
                },
                child: _buildMenuItem(Icons.discount_outlined, 'coupon'.tr)),
            GestureDetector(
                onTap: () {
                  Get.to(const AddressScreen());
                },
                child: _buildMenuItem(Icons.person_add_alt_1, 'addresses'.tr)),
            GestureDetector(
                onTap: () {
                  Get.to(const WarrantyDocumentsScreen());
                },
                child: _buildMenuItem(Icons.shield_outlined, 'warrantyDocuments'.tr)),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Icon(Icons.language_outlined,color: Colors.amber,size: 24,),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Text('language'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
                          color: Colors.black)),
                    ),
                    const Spacer(),
                    Transform.scale(
                        scale: 0.6.w,
                        child:CupertinoSwitch(
                            activeColor: const Color(0xff44A4F2),
                            value: _language,
                            onChanged: (value) {
                              BlocProvider.of<LangCubit>(context).changeLang();
                              setState(() {
                                _language = value;
                              });
                            }
                        )),
                  ],
                ),
              ),
            ),
            // _buildMenuItem(Icons.language_outlined, 'اللغة'),
            GestureDetector(
                onTap: () {
                  Get.to(const TermsConditionsScreen());
                },
                child: _buildMenuItem(Icons.description_outlined, 'termsAndConditions'.tr)),
            Padding(
              padding: EdgeInsets.all(25),
              child: GestureDetector(
                onTap: () async {
                  await HiveHelper.deleteDB();
                  await SharedPreferenceHelper.clearLocalData();
                  AppNavigator.navigateTo(type: NavigationType.navigateAndFinish, widget: SignInView());
                },
                child: Row(
                  children: [
                    AppSVG(
                      svgPath: AppImages.logout,
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 16.w),
                    AppText(
                      text: "logOut".tr,
                      color: Color(0xFFBB0000),
                      textStyles: AppTextStyles.regular16,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  },
);
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.amber, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: mainColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
