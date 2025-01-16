import 'package:flutter/material.dart';

class WarrantyDetailsScreen extends StatelessWidget {
  const WarrantyDetailsScreen({super.key});

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'ضمان السخان',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoItem(
                  'الرقم المرجعي:',
                  '12226HHALLY4H888'
              ),
              _buildInfoItem(
                  'نوع الجهاز:',
                  'سخان غاز تيتو'
              ),
              _buildInfoItem(
                  'اسم البراند:',
                  'اوليمبيك الكترك'
              ),
              _buildInfoItem(
                  'المشكلة الاساسية:',
                  'تسريب غاز إلى الأوضي'
              ),
              _buildInfoItem(
                  'تاريخ بداية الضمان:',
                  '1/1/2025'
              ),
              _buildInfoItem(
                  'تاريخ نهاية الضمان بعد شهر:',
                  '1/2/2025'
              ),
              const SizedBox(height: 24),
              const Text(
                'الإجراءات المتخذة لعملية التسريب وتوفير الضمان:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildBulletPoint(
                  'شروط الضمان: يرجع للعميل إذا في حالة الإخلال بأي شرط يعتبر الضمان لاغي'
              ),
              _buildBulletPoint(
                  'يبدأ الضمان من تاريخ خدمة الصيانة ويستمر لمدة عام كامل، وبالتالي يتم تغطية أي مشكلة تحدث خلال هذه الفترة بدون تكلفة'
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}