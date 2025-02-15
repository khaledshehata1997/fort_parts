import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/address_cubit/address_states.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_states.dart';
import 'package:fort_parts/view/cart_view/widgets/change_address_bottom_sheet.dart';
import 'package:fort_parts/view/home_layout/home_layout.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:fort_parts/view/profile_view/coupons_view.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:local_storage/local_storage.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final TextEditingController pointsController = TextEditingController();
  Address? selectedAddress;
  String selectedCoupon = "";
  String selectedDate = "";
  String selectedTime = "";
  int pos = 0;
  int selectedPoints = 0;

  double calculateTotalAmount() {
    final cubit = context.read<CartCubit>();
    final double cartTotal = cubit.cart.total;
    return cartTotal;
  }

  int calculateDiscountAmount() {
    if (pos != 0 && pointsController.text.isNotEmpty) {
      final int allowedPoints = (int.parse(pointsController.text) / pos).toInt();

      return allowedPoints;
    }
    return 0;
  }

  @override
  void initState() {
    context.read<AddressCubit>().fetchAddresses();
    context.read<AuthenticationCubit>().fetchProfile();
    context.read<SettingsCubit>().fetchPosToMoney();

    super.initState();
  }

  @override
  void dispose() {
    pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('تأكيد الطلب', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Section
              BlocListener<AddressCubit, AddressStates>(
                listenWhen: (previous, current) => current is FetchAddressesState,
                listener: (context, state) {
                  if (state is FetchAddressesState && state.stateStatus == StateStatus.success && state.addresses.isNotEmpty) {
                    setState(() {
                      selectedAddress = state.addresses.firstWhere((element) => element.isDefault);
                    });
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "العنوان : ${selectedAddress?.address ?? ""}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8), // Space between text and button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    elevation: 0.0,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) => ChangeAddressBottomSheet(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedAddress = value;
                                      });
                                    }
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerRight,
                                ),
                                child: Text(
                                  'تغيير العنوان',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: mainColor,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),

              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: BlocListener<AuthenticationCubit, AuthenticationStates>(
                      listenWhen: (previous, current) => current is FetchProfileState,
                      listener: (context, state) {
                        if (state is FetchProfileState && state.stateStatus == StateStatus.success && state.user!.activeCoupon.isNotEmpty) {
                          setState(() {
                            selectedCoupon = state.user!.activeCoupon;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          AppText(
                            text: selectedCoupon.isNotEmpty ? selectedCoupon : "أدخل الكوبون الخاص بك",
                            color: Color(0xFFAFB1B6),
                            textStyles: AppTextStyles.regular14,
                          ),
                          const Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(4.r),
                            onTap: () async {
                              await AppNavigator.navigateTo(
                                type: NavigationType.navigateTo,
                                widget: const CouponsScreen(),
                              ).then((_) {
                                if (context.mounted) {
                                  final cubit = context.read<AuthenticationCubit>();
                                  cubit.fetchProfile();
                                }
                              });
                            },
                            child: Container(
                              width: 65.w,
                              height: 30.h,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(4.r), border: Border.all(width: 1.0, color: AppColors.fE0AA06)),
                              child: Center(
                                child: AppText(
                                  text: "تفعيل",
                                  color: Color(0xFF333333),
                                  textStyles: AppTextStyles.regular16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              BlocListener<SettingsCubit, SettingsStates>(
                listenWhen: (previous, current) => current is FetchPostToMoneyState,
                listener: (context, state) {
                  if (state is FetchPostToMoneyState && state.stateStatus == StateStatus.success) {
                    pos = state.pos;
                  }
                },
                child: FutureBuilder(
                  future: HiveHelper.get(hiveBox: HiveBoxes.user),
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data.pos < 1) {
                      return SizedBox();
                    }
                    return Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: "أدخل نقاط الولاء الخاصة بك",
                                  color: Color(0xFF753C18),
                                  textStyles: AppTextStyles.medium16,
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      width: 140.w,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.r), border: Border.all(width: 1.0, color: AppColors.fE0AA06)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: pointsController,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  if (int.parse(pointsController.text) > snapshot.data.pos) {
                                                    pointsController.text = snapshot.data.pos.toString();
                                                  }
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "0",
                                                  prefixStyle: TextStyle(color: Color(0xFF753C18)),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                                                    borderRadius: BorderRadius.circular(5),
                                                  )),
                                            ),
                                          ),
                                          AppText(
                                            text: "نقطة",
                                            color: Color(0xFF753C18),
                                            textStyles: AppTextStyles.medium16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    AppText(
                                      text: "الخصم: ${calculateDiscountAmount()} ريال سعودي",
                                      color: Color(0xFF753C18),
                                      textStyles: AppTextStyles.bold16,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                InkWell(
                                  borderRadius: BorderRadius.circular(4.r),
                                  onTap: () {
                                    if (pointsController.text.isNotEmpty && int.parse(pointsController.text) >= pos) {
                                      setState(() {
                                        selectedPoints = calculateDiscountAmount() * pos;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 375.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(width: 1.0, color: AppColors.fE0AA06),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text: "تفعيل",
                                        color: Color(0xFF753C18),
                                        textStyles: AppTextStyles.bold16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              // Total Amount Section
              Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Icon(Icons.monetization_on_outlined, size: 30, color: mainColor),
                            SizedBox(width: 8),
                            Text(
                              'المبلغ الإجمالي : ${calculateTotalAmount()} جنيه',
                              style: TextStyle(
                                fontSize: 23,
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      // Payment Method Section
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'طريقة الدفع',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Radio Buttons for Payment Methods
                      PaymentMethodRadio(
                        title: 'كاش',
                        groupValue: 'cash',
                        value: 'cash',
                        onChanged: (value) {},
                      ),
                      if (false)
                        PaymentMethodRadio(
                          title: 'Credit - Debit Card',
                          groupValue: 'cash',
                          value: 'card',
                          onChanged: (value) {},
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light(),
                        child: child!,
                      );
                    },
                  );

                  if (date != null) {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light(),
                          child: child!,
                        );
                      },
                    );

                    if (time != null) {
                      setState(() {
                        selectedDate = DateFormat('yyyy-MM-dd').format(date);
                        selectedTime = time.format(context);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم اختيار التاريخ: $selectedDate والوقت: $selectedTime'),
                        ),
                      );
                    }
                  }
                },
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: // Date Note
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.calendar_today, color: mainColor, size: 25),
                        Text(
                          selectedDate.isNotEmpty && selectedTime.isNotEmpty ? '$selectedDate - $selectedTime' : 'اختر موعد وتوقيت زياره الفني',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Submit Button
              BlocListener<OrderCubit, OrderStates>(
                listenWhen: (previous, current) => current is PlaceOrderState,
                listener: (context, state) {
                  if (state is PlaceOrderState && state.stateStatus == StateStatus.success) {
                    final cubit = context.read<HomeLayoutCubit>();
                    cubit.changeScreenBody(index: 0);
                    AppNavigator.navigateTo(type: NavigationType.navigateAndFinish, widget: const HomeLayout());
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedAddress != null && selectedDate.isNotEmpty && selectedTime.isNotEmpty) {
                      final cubit = context.read<OrderCubit>();
                      cubit.placeOrder(
                        addressID: selectedAddress!.id,
                        date: selectedDate,
                        time: selectedTime,
                        coupon: selectedCoupon,
                        pos: selectedPoints.toString(),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: Size(double.infinity, 60), // Increased height (60)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Less rounded corners (8)
                    ),
                  ),
                  child: const Text(
                    'أرسال الطلب',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodRadio extends StatelessWidget {
  final String title;
  final String groupValue;
  final String value;
  final Function(String?) onChanged;

  const PaymentMethodRadio({
    super.key,
    required this.title,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        activeColor: mainColor,
        title: Align(
          alignment: Alignment.centerRight, // Aligns text to the right
          child: Text(
            title,
            textAlign: TextAlign.right,
          ),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        // Adds space around the widget
        controlAffinity: ListTileControlAffinity.leading, // Places the radio button on the left
      ),
    );
  }
}
