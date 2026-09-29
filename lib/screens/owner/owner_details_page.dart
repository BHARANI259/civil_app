import 'package:flutter/material.dart';
import 'owner_dashboard_page.dart';

class OwnerDetailsPage extends StatelessWidget {
  const OwnerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Details'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Owner Details',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Owner Name',
                hintText: 'Enter owner name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email ID',
                hintText: 'Enter email',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Project Budget',
                hintText: 'Enter budget',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Floors',
                hintText: 'Enter number of floors',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Workers',
                hintText: 'Enter number of workers',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Project Location',
                hintText: 'Enter site location',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OwnerDashboardPage(),
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}