import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:fort_parts/view/auth/otv_verification_view.dart';
import 'package:fort_parts/view/auth/sign_up_view.dart';
import 'package:get/get.dart';

class SignInView extends StatefulWidget {
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Container(width: 100, height: 100, child: Image.asset('images/logo.png')),
              SizedBox(
                height: 40,
              ),
              Container(margin: EdgeInsets.only(right: 15), width: Get.width * .9, height: 70, child: Image.asset('icons/welcome2.png')),
              SizedBox(
                height: 25,
              ),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 10),
                  width: Get.width * .88,
                  height: 50,
                  child: Image.asset(
                    'icons/phonenumber.png',
                    width: 100,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: "5XXXXXXXX",
                      prefixStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: Get.height * .1,
              ),
              BlocListener<AuthenticationCubit, AuthenticationStates>(
                listenWhen: (previous, current) => current is LoginState,
                listener: (context, state) {
                  if (state is LoginState && state.stateStatus == StateStatus.success) {
                    AppNavigator.navigateTo(
                        type: NavigationType.navigateTo,
                        widget: state.isRegistered
                            ? OtvVerificationView(
                                phone: "966${phoneController.text}",
                              )
                            : SignUpView(
                                phoneNumber: phoneController.text,
                              ));
                  }

                  if (state is LoginState && state.stateStatus == StateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('رقمم الهاتف غير صحيح'),
                      ),
                    );
                  }
                },
                child: GestureDetector(
                  onTap: () async {
                    if (phoneController.text.isNotEmpty && phoneController.text.length == 9) {
                      final cubit = context.read<AuthenticationCubit>();
                      cubit.login(
                        phone: "966${phoneController.text}",
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('رقمم الهاتف غير صحيح'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    width: Get.width,
                    height: 65,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4), color: mainColor, border: Border.all(color: mainColor, width: 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpView(phoneNumber: ""));
                    },
                    child: Text('إنشاء حساب ',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: mainColor,
                            fontSize: 18,
                            color: mainColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'ليس لديك حساب؟ ',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
