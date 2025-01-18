import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:fort_parts/view/auth/otv_verification_view.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../constants.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
                height: 60,
              ),
              Container(width: 100, height: 90, child: Image.asset('images/logo.png')),
              SizedBox(
                height: 40,
              ),
              Container(
                  margin: EdgeInsets.only(left: Get.width * .1, bottom: 20),
                  width: Get.width,
                  height: 70,
                  child: Image.asset('icons/welcome_signup.png')),
              Container(
                  margin: EdgeInsets.only(right: 15, bottom: 15),
                  alignment: Alignment.topRight,
                  child: Text(
                    'الاسم الشخصي',
                    style: TextStyle(fontSize: 17),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 10, top: 25),
                  width: Get.width * .88,
                  height: 35,
                  child: Image.asset(
                    'icons/email_auth.png',
                    width: 100,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "email@example.com",
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
                height: 20,
              ),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 10),
                  width: Get.width * .88,
                  height: 35,
                  child: Image.asset(
                    'icons/phonenumber.png',
                    width: 85,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: IntlPhoneField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    labelText: '5XXXXXXXX',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  initialCountryCode: 'SA',
                ),
              ),
              SizedBox(
                height: Get.height * .025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text('الشروط والاحكام',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: mainColor,
                          fontSize: 16,
                          color: mainColor,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    'الموافقه علي ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              BlocListener<AuthenticationCubit, AuthenticationStates>(
                listenWhen: (previous, current) => current is RegisterState,
                listener: (context, state) {
                  if (state is RegisterState && state.stateStatus == StateStatus.success) {
                    AppNavigator.navigateTo(
                        type: NavigationType.navigateTo,
                        widget: OtvVerificationView(
                          phone: "966${phoneController.text}",
                        ));
                  }

                  if (state is RegisterState && state.stateStatus == StateStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('حدث خطأ ف التسجيل'),
                      ),
                    );
                  }
                },
                child: GestureDetector(
                  onTap: () async {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        phoneController.text.length == 9) {
                      final cubit = context.read<AuthenticationCubit>();
                      cubit.register(
                        name: nameController.text,
                        email: emailController.text,
                        phone: "966${phoneController.text}",
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('البيانات غير صحيحه'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'إنشاء حساب',
                      style:
                          TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    width: Get.width,
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: mainColor,
                        border: Border.all(color: mainColor, width: 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
