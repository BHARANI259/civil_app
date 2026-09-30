import 'package:flutter/material.dart';

class AddSupervisorPage extends StatefulWidget {
  const AddSupervisorPage({super.key});

  @override
  State<AddSupervisorPage> createState() =>
      _AddSupervisorPageState();
}

class _AddSupervisorPageState
    extends State<AddSupervisorPage> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final id = TextEditingController();

  void addSupervisor() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Supervisor added successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Supervisor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Supervisor Details',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            _field(name, 'Supervisor Name'),
            _field(phone, 'Mobile Number'),
            _field(email, 'Email'),
            _field(id, 'Supervisor ID'),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: addSupervisor,
                child: const Text('Assign Supervisor'),
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