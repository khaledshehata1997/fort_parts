import 'package:flutter/material.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            'الكوبونات',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: [

              Tab(text: 'المنتهية'),
              Tab(text: 'المتاحة'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [

            // Expired Coupons
            ExpiredCouponsTab(),
            // Available Coupons
            AvailableCouponsTab(),
          ],
        ),
      ),
    );
  }
}

class AvailableCouponsTab extends StatelessWidget {
  const AvailableCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCouponCard(
            value: '10 ريس',
            expiryDate: 'صالح حتى يوم 30 مايو 2025',
            isActive: true,
          ),
          _buildCouponCard(
            value: '20 ريس',
            expiryDate: 'صالح حتى يوم 15 يونيو 2025',
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required String value,
    required String expiryDate,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Coupon Icon
          Container(
            height: 40,
            width: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('icons/img_9.png'),
          ),
          const SizedBox(width: 16),
          // Coupon Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  expiryDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Activation Switch
          Switch(
            value: isActive,
            onChanged: (value) {},
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class ExpiredCouponsTab extends StatelessWidget {
  const ExpiredCouponsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCouponCard(
            value: '5 ريس',
            expiryDate: 'انتهى في 15 مايو 2024',
            isActive: false,
          ),
          _buildCouponCard(
            value: '15 ريس',
            expiryDate: 'انتهى في 20 أبريل 2024',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({
    required String value,
    required String expiryDate,
    required bool isActive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Coupon Icon
          Container(
            height: 40,
            width: 42,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('icons/img_9.png'),
          ),
          const SizedBox(width: 16),
          // Coupon Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  expiryDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Activation Switch
          // Switch(
          //   value: isActive,
          //   onChanged: null,
          //   activeColor: Colors.green,
          // ),
        ],
      ),
    );
  }
}
