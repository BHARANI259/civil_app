
import 'package:flutter/material.dart';

class WorkerManagementPage extends StatefulWidget {
  const WorkerManagementPage({super.key});

  @override
  State<WorkerManagementPage> createState() =>
      _WorkerManagementPageState();
}

class _WorkerManagementPageState
    extends State<WorkerManagementPage> {
  final category = TextEditingController();
  final headcount = TextEditingController();
  final wage = TextEditingController();

  double get salary =>
      (double.tryParse(headcount.text) ?? 0) *
      (double.tryParse(wage.text) ?? 0);

  @override
  void dispose() {
    category.dispose();
    headcount.dispose();
    wage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF087F8C);
    const navy = Color(0xFF123B5D);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F8),
      appBar: AppBar(
        title: const Text('Worker Management'),
        backgroundColor: teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: navy.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.groups_rounded,
                  size: 65,
                  color: teal,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Worker Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the daily workforce information.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 28),
                field(category, 'Worker Category', false),
                field(headcount, 'Total Headcount', true),
                field(wage, 'Daily Wage per Worker (₹)', true),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF5EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'TOTAL SALARY TODAY',
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 1,
                          color: teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${salary.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final count =
                          int.tryParse(headcount.text.trim());
                      final dailyWage =
                          double.tryParse(wage.text.trim());

                      if (category.text.trim().isEmpty ||
                          count == null ||
                          count <= 0 ||
                          dailyWage == null ||
                          dailyWage < 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Enter valid worker details',
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.pop(context, {
                        'Category': category.text.trim(),
                        'Headcount': count.toString(),
                        'Daily Wage': dailyWage.toStringAsFixed(2),
                        'Total Salary': salary.toStringAsFixed(2),
                      });
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: const Text(
                      'Save Worker Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget field(
    TextEditingController controller,
    String label,
    bool number,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: number
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        onChanged: (_) {
          if (number) setState(() {});
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF7F9FC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: Color(0xFFDCE5EC),
            ),
          ),
        ),
      ),
    );
  }
}