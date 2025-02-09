import 'dart:io';

import 'package:components/components.dart';
import 'package:file_services/file_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_storage/local_storage.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  XFile? pickedImage;

  Future<void> fetchUserData() async {
    final HiveUser user = await HiveHelper.get(hiveBox: HiveBoxes.user);
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone.substring(3);
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

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
          'البيانات الشخصية',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image Section
                Center(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: HiveHelper.get(hiveBox: HiveBoxes.user),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.data == null) return SizedBox();
                          return pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.file(
                                    File(pickedImage!.path),
                                    width: 40.w,
                                    height: 40.w,
                                  ),
                                )
                              : AppCachedNetworkImage(
                                  imageUrl: snapshot.data.image,
                                  height: 40,
                                  width: 40,
                                  radius: 100,
                                );
                        },
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () async {
                          final XFile? image = await FileServices.pickImage();
                          if (image != null) {
                            setState(() {
                              pickedImage = image;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.grey,
                        ),
                        label: const Text(
                          'تحميل صورة جديدة',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form Fields

                const Text(
                  'الاسم',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  hint: 'أدخل اسمك',
                  controller: nameController,
                ),

                const SizedBox(height: 16),
                const Text(
                  'البريد الإلكتروني',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  hint: 'example@email.com',
                  controller: emailController,
                ),

                const SizedBox(height: 16),
                const Text(
                  'رقم الجوال',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildPhoneField(controller: phoneController),

                const SizedBox(height: 32),
                // Save Button
                BlocListener<AuthenticationCubit, AuthenticationStates>(
                  listenWhen: (previous, current) => current is UpdateProfileState,
                  listener: (BuildContext context, state) async {
                    if (state is UpdateProfileState && state.stateStatus == StateStatus.success) {
                      // final cubit = context.read<AuthenticationCubit>();
                      // await HiveHelper.put(hiveBox: HiveBoxes.user, data: state.user.toHiveUser);
                      // fetchUserData();
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                          final cubit = context.read<AuthenticationCubit>();
                          cubit.updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            image: pickedImage,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'حفظ التعديلات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildPhoneField({
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: 'أدخل رقم الجوال',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: Colors.grey[300],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Image.asset(
                  'icons/saudi_flag.png',
                  width: 24,
                  height: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '+966',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
