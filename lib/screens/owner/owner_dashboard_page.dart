import 'package:flutter/material.dart';
import 'add_supervisor_page.dart';

class OwnerDashboardPage extends StatelessWidget {
  final String name;
  final String building;
  final String location;
  final String budget;
  final String floors;
  final String workers;

  const OwnerDashboardPage({
    super.key,
    required this.name,
    required this.building,
    required this.location,
    required this.budget,
    required this.floors,
    required this.workers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $name',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text('Project Overview'),

            const SizedBox(height: 20),

            _info('Building', building),
            _info('Location', location),
            _info('Budget', '₹ $budget'),
            _info('Floors', floors),
            _info('Workers', workers),

            const SizedBox(height: 20),

            const Text(
              'Project Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const LinearProgressIndicator(value: 0.45),

            const SizedBox(height: 8),

            const Text('45% Completed'),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddSupervisorPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Add Supervisor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}