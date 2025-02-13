import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';
import 'package:fort_parts/view/profile_view/warranty_details_screen.dart';
import 'package:get/get.dart';

class WarrantyDocumentsScreen extends StatefulWidget {
  const WarrantyDocumentsScreen({super.key});

  @override
  State<WarrantyDocumentsScreen> createState() => _WarrantyDocumentsScreenState();
}

class _WarrantyDocumentsScreenState extends State<WarrantyDocumentsScreen> {
  @override
  void initState() {
    final cubit = context.read<OrderCubit>();
    cubit.fetchCertificates();
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
        child: BlocBuilder<OrderCubit, OrderStates>(
          buildWhen: (previous, current) => current is FetchCertificatesState,
          builder: (context, state) {
            if (state is FetchCertificatesState) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return state.stateStatus == StateStatus.success
                      ? GestureDetector(
                          onTap: () {
                            Get.to(WarrantyDetailsScreen(
                              certificateID: state.certificates[index].id,
                            ));
                          },
                          child: _buildDocumentCard(
                            title: state.certificates[index].product.name,
                            subtitle: state.certificates[index].product.description,
                            date: state.certificates[index].endDate,
                            image: state.certificates[index].product.image,
                          ),
                        )
                      : AppShimmer(
                          child: Container(
                          height: 133,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
                itemCount: state.stateStatus == StateStatus.success ? state.certificates.length : 2,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required String date,
    required String image,
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
            AppCachedNetworkImage(imageUrl: image, height: 80, width: 80),
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
