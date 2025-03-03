import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:fort_parts/view/home_layout/home_layout.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtvVerificationView extends StatefulWidget {
  const OtvVerificationView({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<OtvVerificationView> createState() => _OtvVerificationViewState();
}

class _OtvVerificationViewState extends State<OtvVerificationView> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: mainColor),
    ),
  );

  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.

    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(width: 100, height: 90, child: Image.asset('images/logo.png')),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "enterOtp".tr,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff333333),
                ),
              ),
              Text(
                "enterFourOtpNo".tr,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffA9AAAA),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              BlocListener<AuthenticationCubit, AuthenticationStates>(
                listenWhen: (previous, current) => current is OTPVerificationState,
                listener: (context, state) async {
                  if (state is OTPVerificationState && state.stateStatus == StateStatus.success) {
                    final cubit = context.read<AuthenticationCubit>();
                    await cubit.updateDataLocally(loggedUser: state.loggedUser!);
                    AppNavigator.navigateTo(
                      type: NavigationType.navigateAndFinish,
                      widget: HomeLayout(),
                    );
                  }
                  if (state is OTPVerificationState && state.stateStatus == StateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('otpIncorrect'.tr),
                      ),
                    );
                  }
                },
                child: Center(
                  child: Pinput(
                    // You can pass your own SmsRetriever implementation based on any package
                    // in this example we are using the SmartAuth
                    controller: pinController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    validator: (value) {
                      return;
                    },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      final cubit = context.read<AuthenticationCubit>();
                      cubit.otpVerification(phone: widget.phone, otp: pin);
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: mainColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: mainColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: mainColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  final cubit = context.read<AuthenticationCubit>();
                  cubit.resendOTP();
                },
                child: Container(padding: EdgeInsets.symmetric(horizontal: 20), height: 90, child: Image.asset('icons/resend_otp.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
