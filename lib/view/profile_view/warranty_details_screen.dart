import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';

class WarrantyDetailsScreen extends StatelessWidget {
  const WarrantyDetailsScreen({
    super.key,
    required this.certificate,
  });

  final Certificate certificate;

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
              Text(
                certificate.product.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoItem('الرقم المرجعي:', certificate.code),
              _buildInfoItem('نوع الجهاز:', certificate.type),
              _buildInfoItem('اسم البراند:', certificate.brand),
              _buildInfoItem('المشكلة الاساسية:', certificate.problem),
              _buildInfoItem('تاريخ بداية الضمان:', certificate.startDate),
              _buildInfoItem('تاريخ نهاية الضمان بعد شهر:', certificate.endDate),
              _buildInfoItem('الإجراءات المتخذة:', certificate.procedure),
              const SizedBox(height: 16),
              _buildBulletPoint('شروط الضمان: يرجع للعميل إذا في حالة الإخلال بأي شرط يعتبر الضمان لاغي'),
              _buildBulletPoint(
                  'يبدأ الضمان من تاريخ خدمة الصيانة ويستمر لمدة عام كامل، وبالتالي يتم تغطية أي مشكلة تحدث خلال هذه الفترة بدون تكلفة'),
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
