
import 'package:flutter/material.dart';

class MaterialRequestPage extends StatefulWidget {
  const MaterialRequestPage({super.key});

  @override
  State<MaterialRequestPage> createState() =>
      _MaterialRequestPageState();
}

class _MaterialRequestPageState
    extends State<MaterialRequestPage> {
  final item = TextEditingController();
  final quantity = TextEditingController();
  final unit = TextEditingController();

  DateTime? requiredDate;
  String urgency = 'Medium';

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => requiredDate = date);
    }
  }

  @override
  void dispose() {
    item.dispose();
    quantity.dispose();
    unit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Request'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const Icon(
            Icons.inventory_2_rounded,
            size: 60,
            color: Color(0xFF087F8C),
          ),
          const SizedBox(height: 16),
          const Text(
            'Material Requirements',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          field(item, 'Material Item'),
          field(quantity, 'Quantity Required'),
          field(unit, 'Unit (bags, kg, litres, pieces)'),
          OutlinedButton.icon(
            onPressed: chooseDate,
            icon: const Icon(Icons.calendar_month),
            label: Text(
              requiredDate == null
                  ? 'Select Required Date'
                  : '${requiredDate!.day}/${requiredDate!.month}/${requiredDate!.year}',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: urgency,
            decoration: const InputDecoration(
              labelText: 'Urgency Level',
              border: OutlineInputBorder(),
            ),
            items: ['Low', 'Medium', 'High']
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => urgency = value);
              }
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (item.text.trim().isEmpty ||
                  quantity.text.trim().isEmpty ||
                  unit.text.trim().isEmpty ||
                  requiredDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fill all material details'),
                  ),
                );
                return;
              }

              Navigator.pop(context, {
                'Item': item.text.trim(),
                'Quantity': quantity.text.trim(),
                'Unit': unit.text.trim(),
                'Required By':
                    '${requiredDate!.day}/${requiredDate!.month}/${requiredDate!.year}',
                'Urgency': urgency,
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF087F8C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Save Material Request'),
          ),
        ],
      ),
    );
  }

  Widget field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}