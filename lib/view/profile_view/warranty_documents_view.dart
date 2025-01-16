import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/view/profile_view/warranty_details_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WarrantyDocumentsScreen extends StatelessWidget {
  const WarrantyDocumentsScreen({super.key});

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
          'وثائق الضمان',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: (){
                Get.to(const WarrantyDetailsScreen());
              },
              child: _buildDocumentCard(
                title: 'ضمان السخان',
                subtitle: 'الضمان الخاص بتصليح السخان',
                date: '12 ديسمبر 2024',
                icon: Icons.lock,
                backgroundColor: Colors.white,
                iconColor: const Color(0xffe2ffe9),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: (){
                Get.to(const WarrantyDetailsScreen());
              },
              child: _buildDocumentCard(
                title: 'ضمان تمديد الأسلاك',
                subtitle: 'الضمان الخاص بتصليح السخان',
                date: '20 ديسمبر 2024',
                icon: Icons.electric_bolt,
                backgroundColor: Colors.white,
                iconColor: const Color(0xffe2ffe9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required String date,
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: mainColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        'ينتهي الضمان في: $date',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}