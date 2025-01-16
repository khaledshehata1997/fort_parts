import 'package:flutter/material.dart';
import 'package:fort_parts/constants.dart';
import 'package:fort_parts/main.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' hide TextDirection;

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('تأكيد الطلب', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            SizedBox(
              width: double.infinity,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العنوان :  3ش التحرير, جدة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8), // Space between text and button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerRight,
                            ),
                            child: Text(
                              'تغيير العنوان',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: mainColor,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Total Amount Section
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on_outlined,
                              size: 30, color: mainColor),
                          SizedBox(width: 8),
                          Text(
                            'المبلغ الإجمالي : 1200 جنيه',
                            style: TextStyle(
                              fontSize: 23,
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    // Payment Method Section
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'طريقة الدفع',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Radio Buttons for Payment Methods
                    PaymentMethodRadio(
                      title: 'كاش',
                      groupValue: 'cash',
                      value: 'cash',
                      onChanged: (value) {},
                    ),
                    PaymentMethodRadio(
                      title: 'Credit - Debit Card',
                      groupValue: 'cash',
                      value: 'card',
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.light(),
                      child: child!,
                    );
                  },
                );

                if (selectedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light(),
                        child: child!,
                      );
                    },
                  );

                  if (selectedTime != null) {
                    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                    final formattedTime = selectedTime.format(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم اختيار التاريخ: $formattedDate والوقت: $formattedTime'),
                      ),
                    );
                  }
                }
              },
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:  // Date Note
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.calendar_today, color: mainColor, size: 25),
                      Text(
                        'اختر موعد وتوقيت زياره الفني',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                Get.to(const PaymentView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 60), // Increased height (60)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Less rounded corners (8)
                ),
              ),
              child: const Text('أرسال الطلب',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentMethodRadio extends StatelessWidget {
  final String title;
  final String groupValue;
  final String value;
  final Function(String?) onChanged;

  const PaymentMethodRadio({
    super.key,
    required this.title,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        activeColor: mainColor,
        title: Align(
          alignment: Alignment.centerRight, // Aligns text to the right
          child: Text(
            title,
            textAlign: TextAlign.right,
          ),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        contentPadding: EdgeInsets.symmetric(horizontal: 16), // Adds space around the widget
        controlAffinity: ListTileControlAffinity.leading, // Places the radio button on the left
      ),
    );
  }
}
