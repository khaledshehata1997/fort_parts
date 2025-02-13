import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';

class WarrantyDetailsScreen extends StatefulWidget {
  const WarrantyDetailsScreen({
    super.key,
    required this.certificateID,
  });

  final int certificateID;

  @override
  State<WarrantyDetailsScreen> createState() => _WarrantyDetailsScreenState();
}

class _WarrantyDetailsScreenState extends State<WarrantyDetailsScreen> {
  @override
  void initState() {
    final cubit = context.read<OrderCubit>();
    cubit.fetchCertificate(certificateID: widget.certificateID);
    super.initState();
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
          child: BlocBuilder<OrderCubit, OrderStates>(
            buildWhen: (previous, current) => current is FetchCertificateState,
            builder: (context, state) {
              if (state is FetchCertificateState) {
                return state.stateStatus == StateStatus.success
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.certificate!.product.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildInfoItem('الرقم المرجعي:', state.certificate!.code),
                          _buildInfoItem('نوع الجهاز:', state.certificate!.type),
                          _buildInfoItem('اسم البراند:', state.certificate!.brand),
                          _buildInfoItem('المشكلة الاساسية:', state.certificate!.problem),
                          _buildInfoItem('تاريخ بداية الضمان:', state.certificate!.startDate),
                          _buildInfoItem('تاريخ نهاية الضمان بعد شهر:', state.certificate!.endDate),
                          _buildInfoItem('الإجراءات المتخذة:', state.certificate!.procedure),
                          const SizedBox(height: 16),
                          _buildBulletPoint('شروط الضمان: يرجع للعميل إذا في حالة الإخلال بأي شرط يعتبر الضمان لاغي'),
                          _buildBulletPoint(
                              'يبدأ الضمان من تاريخ خدمة الصيانة ويستمر لمدة عام كامل، وبالتالي يتم تغطية أي مشكلة تحدث خلال هذه الفترة بدون تكلفة'),
                        ],
                      )
                    : const SizedBox();
              }
              return const SizedBox();
            },
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
