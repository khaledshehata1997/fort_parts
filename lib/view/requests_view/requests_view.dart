import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('الطلبات', style: TextStyle(fontSize: 18)),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'الملغاة'),
              Tab(text: 'المنتهية'),
              Tab(text: 'الجارية'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabContent(
              orderStatus: 'الملغاة',
              details: [
                {'icon': 'icons/settings.png', 'text': 'الطلب: ', 'subText': 'تنظيف مواسير', 'color': Colors.black},
                {'icon': 'icons/img_4.png', 'text': 'السعر: ', 'subText': '100 ر.س', 'color': Colors.amber},
              ],
            ),
            TabContent(
              orderStatus: 'المنتهية',
              details: [
                {'icon': 'icons/settings.png', 'text': 'الطلب: ', 'subText': 'تمديد أسلاك', 'color': Colors.black},
                {'icon': 'icons/img_7.png', 'text': 'الفني: ', 'subText': ' محمد علي', 'color': Colors.amber},
                {'icon': 'icons/img_4.png', 'text': 'السعر: ', 'subText': '100 ر.س', 'color': Colors.black},
                {'icon': 'icons/img_5.png', 'text': 'ميعاد الزيارة:  ', 'subText': '1/8/2024', 'color': Colors.black},
              ],
            ),
            TabContent(
              orderStatus: 'الجارية',
              details: [
                {'icon': 'icons/settings.png', 'text': 'الطلب: ', 'subText': 'تجديد أسلاك', 'color': Colors.black},
                {'icon': 'icons/img_4.png', 'text': 'السعر:  ', 'subText': '100 ر.س', 'color': Colors.amber},
                {'icon': 'icons/img_5.png', 'text': 'تاريخ الزيارة: ', 'subText': '1/8/2024', 'color': Colors.black},
                {'icon': 'icons/img_6.png', 'text': 'ميعاد الزيارة الذي حددته: ', 'subText': '9:00 صباحا', 'color': Colors.black},
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String orderStatus;
  final List<Map<String, dynamic>> details;

  const TabContent({
    required this.orderStatus,
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: details
              .map((detail) => _buildDetailRow(
                    icon: detail['icon'],
                    text: detail['text'],
                    subText: detail['subText'],
                    color: detail['color'],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String icon,
    required String text,
    required Color color,
    required subText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Image.asset(
            icon,
            color: icon != 'icons/img_7.png' ? mainColor : null,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
