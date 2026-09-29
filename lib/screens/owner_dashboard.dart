import 'package:flutter/material.dart';

class OwnerDashboard extends StatelessWidget {
  final String ownerName;
  final String budget;
  final String workers;
  final String floors;

  const OwnerDashboard({
    required this.ownerName,
    required this.budget,
    required this.workers,
    required this.floors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $ownerName',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text('$floors Floors Construction'),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.people,
                  color: Colors.orange,
                ),
                title: const Text('Workers'),
                subtitle: Text('$workers Workers'),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.orange,
                ),
                title: const Text('Project Budget'),
                subtitle: Text('₹$budget'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}