import 'package:flutter/material.dart';
import 'owner_dashboard_page.dart';

class OwnerRegistrationPage extends StatefulWidget {
  const OwnerRegistrationPage({super.key});

  @override
  State<OwnerRegistrationPage> createState() =>
      _OwnerRegistrationPageState();
}

class _OwnerRegistrationPageState
    extends State<OwnerRegistrationPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final building = TextEditingController();
  final location = TextEditingController();
  final budget = TextEditingController();
  final floors = TextEditingController();
  final workers = TextEditingController();

  void continuePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OwnerDashboardPage(
          name: name.text,
          building: building.text,
          location: location.text,
          budget: budget.text,
          floors: floors.text,
          workers: workers.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Construction Project',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _field(name, 'Owner Name'),
            _field(email, 'Email'),
            _field(building, 'Building Type'),
            _field(location, 'Construction Location'),
            _field(budget, 'Project Budget'),
            _field(floors, 'Number of Floors'),
            _field(workers, 'Workers Required'),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: continuePage,
                child: const Text('Create Project'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}