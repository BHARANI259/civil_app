import 'package:flutter/material.dart';
import 'owner_dashboard.dart';

class OwnerForm extends StatelessWidget {
  const OwnerForm();

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final email = TextEditingController();
    final budget = TextEditingController();
    final workers = TextEditingController();
    final floors = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Construction Details'),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(    //makes the page scrollable
        padding: const EdgeInsets.all(24),   //spaces at 4 corners
        child: Column(
          children: [
            const Text(
              'Site Details',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: 'Owner Name',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email ID',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: budget,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Project Budget',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: workers,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Number of Workers',
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: floors,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Number of Floors',
              ),
            ),

            //elevated button
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OwnerDashboard(   //Pass the form data to the dashboard
                        ownerName: name.text,
                        budget: budget.text,
                        workers: workers.text,
                        floors: floors.text,
                      ),
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