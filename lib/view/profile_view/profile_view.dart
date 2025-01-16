import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/main.dart';
import 'package:fort_parts/view/profile_view/coupons_view.dart';
import 'package:fort_parts/view/profile_view/notifications_view.dart';
import 'package:fort_parts/view/profile_view/profile_info_screen.dart';
import 'package:fort_parts/view/profile_view/terms_conditions_view.dart';
import 'package:fort_parts/view/profile_view/warranty_documents_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
          'الحساب',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
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
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(const PersonalInfoScreen());
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
                  const Text(
                    'محمد علي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat('النشطة', '50'),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey[300],
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      _buildStat('المستخدمة', '120'),
                    ],
                  ),
                ],
              ),
            ),
            // Menu Items
            GestureDetector(
              onTap: (){
                Get.to(const NotificationsScreen());
              },
                child: _buildMenuItem(Icons.notifications_outlined, 'الإشعارات')),
            GestureDetector(
                onTap: (){
                  Get.to(const CouponsScreen());
                },
                child: _buildMenuItem(Icons.discount_outlined, 'الكوبونات')),
            GestureDetector(
                onTap: (){
                  Get.to(const WarrantyDocumentsScreen());
                },
                child: _buildMenuItem(Icons.shield_outlined, 'وثائق الضمان')),
            _buildMenuItem(Icons.language_outlined, 'اللغة'),
            GestureDetector(
                onTap: (){
                  Get.to(const TermsConditionsScreen());
                },
                child: _buildMenuItem(Icons.description_outlined, 'الشروط والأحكام')),
          ],
        ),
      ),
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