
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
  final project = TextEditingController();
  final owner = TextEditingController();
  final building = TextEditingController();
  final location = TextEditingController();
  final floors = TextEditingController();
  final budget = TextEditingController();
  final spent = TextEditingController();
  final materials = TextEditingController();
  final labour = TextEditingController();
  final workers = TextEditingController();
  final supervisor = TextEditingController();
  final supervisorPhone = TextEditingController();
  final present = TextEditingController();
  final absent = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  double get remaining =>
      (double.tryParse(budget.text) ?? 0) -
      (double.tryParse(spent.text) ?? 0);

  Future<void> chooseDate(bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        if (isStart) {
          startDate = date;
        } else {
          endDate = date;
        }
      });
    }
  }

  String showDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.day}/${date.month}/${date.year}';
  }

  void continueToDashboard() {
    if (project.text.trim().isEmpty ||
        owner.text.trim().isEmpty ||
        building.text.trim().isEmpty ||
        location.text.trim().isEmpty ||
        budget.text.trim().isEmpty ||
        startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill required details and select dates'),
        ),
      );
      return;
    }

    final details = <String, String>{
      'Project Name': project.text,
      'Owner Name': owner.text,
      'Building Type': building.text,
      'Construction Location': location.text,
      'Number of Floors': floors.text,
      'Construction Start Date': showDate(startDate),
      'Expected End Date': showDate(endDate),
      'Estimated Budget': budget.text,
      'Amount Spent': spent.text,
      'Remaining Budget': remaining.toStringAsFixed(2),
      'Material Expenses': materials.text,
      'Labour Expenses': labour.text,
      'Workers Today': workers.text,
      'Supervisor Name': supervisor.text,
      'Supervisor Phone': supervisorPhone.text,
      'Workers Present': present.text,
      'Workers Absent': absent.text,
    };

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OwnerDashboardPage(details: details),
      ),
    );
  }

  @override
  void dispose() {
    project.dispose();
    owner.dispose();
    building.dispose();
    location.dispose();
    floors.dispose();
    budget.dispose();
    spent.dispose();
    materials.dispose();
    labour.dispose();
    workers.dispose();
    supervisor.dispose();
    supervisorPhone.dispose();
    present.dispose();
    absent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Owner Details')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Construction Project',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          field(project, 'Project Name'),
          field(owner, 'Owner Name'),
          field(building, 'Building Type (House, Apartment...)'),
          field(location, 'Construction Location'),
          field(floors, 'Number of Floors', number: true),
          dateField('Construction Start Date', startDate, true),
          dateField('Expected End Date', endDate, false),
          field(budget, 'Total Estimated Budget (₹)', number: true),
          field(spent, 'Amount Spent So Far (₹)', number: true),
          Card(
            child: ListTile(
              title: const Text('Remaining Budget'),
              subtitle: Text(
                '₹${remaining.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          field(materials, 'Material Expenses (₹)', number: true),
          field(labour, 'Labour Expenses (₹)', number: true),
          field(workers, 'Total Workers Today', number: true),
          field(supervisor, 'Supervisor Name'),
          field(supervisorPhone, 'Supervisor Phone Number',
              number: true),
          field(present, 'Workers Present Today', number: true),
          field(absent, 'Workers Absent Today', number: true),
          const SizedBox(height: 18),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: continueToDashboard,
              child: const Text('Save Project Details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget field(
    TextEditingController controller,
    String label, {
    bool number = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: number
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        onChanged: (_) {
          if (label.contains('Budget') ||
              label.contains('Spent So Far')) {
            setState(() {});
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget dateField(
    String label,
    DateTime? date,
    bool isStart,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: OutlinedButton(
        onPressed: () => chooseDate(isStart),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 12),
              Expanded(
                child: Text('$label: ${showDate(date)}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}