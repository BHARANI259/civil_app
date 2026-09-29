import 'package:flutter/material.dart';

class OwnerPortalPage extends StatelessWidget {
  const OwnerPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Owner Portal',
        ),
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_center_outlined,
              size: 70,
              color: Color(0xFF1769AA),
            ),

            SizedBox(height: 20),

            Text(
              'Owner Portal',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF123B5D),
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Owner login successful',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}