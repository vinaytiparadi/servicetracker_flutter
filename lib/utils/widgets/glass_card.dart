import 'package:flutter/material.dart';
import '../../models/FormModel.dart';

class GlassCard extends StatelessWidget {
  final FormData data;

  GlassCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xffdad5).withOpacity(1),
            blurRadius: 2.0,
            spreadRadius: 1.5,
          ),
        ],
        color: Colors.white.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                Text(
                  data.customerName,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xbc9c94).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contact Number:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                Text(
                  '+91'+data.customerPrimaryContactNumber,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xac8482).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Device Brand:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                Text(
                  data.customerSmartPhoneBrand,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xac8482).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Device Model:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                Text(
                  data.customerSmartPhoneModel,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xac8482).withOpacity(1.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Repair Cost:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0x846c64).withOpacity(1.0),
                  ),
                ),
                Text(
                  '₹'+data.totalRepairCost.toString(),
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color(0xac8482).withOpacity(1.0),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
