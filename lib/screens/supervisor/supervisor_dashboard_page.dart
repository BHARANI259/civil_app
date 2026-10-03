
import 'package:flutter/material.dart';
import 'worker_management_page.dart';
import 'material_request_page.dart';

class SupervisorDashboardPage extends StatefulWidget {
  final Map<String, String> ownerDetails;

  const SupervisorDashboardPage({
    super.key,
    this.ownerDetails = const {},
  });

  @override
  State<SupervisorDashboardPage> createState() =>
      _SupervisorDashboardPageState();
}

class _SupervisorDashboardPageState
    extends State<SupervisorDashboardPage> {
  final List<Map<String, String>> workers = [];
  final List<Map<String, String>> materials = [];

  static const teal = Color(0xFF087F8C);
  static const navy = Color(0xFF123B5D);

  Future<void> addWorker() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => const WorkerManagementPage(),
      ),
    );

    if (result != null && mounted) {
      setState(() => workers.add(result));
    }
  }

  Future<void> addMaterial() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => const MaterialRequestPage(),
      ),
    );

    if (result != null && mounted) {
      setState(() => materials.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalWorkers = workers.fold<int>(
      0,
      (sum, worker) =>
          sum + (int.tryParse(worker['Headcount'] ?? '') ?? 0),
    );

    final totalSalary = workers.fold<double>(
      0,
      (sum, worker) =>
          sum + (double.tryParse(worker['Total Salary'] ?? '') ?? 0),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7F8),
      appBar: AppBar(
        backgroundColor: teal,
        foregroundColor: Colors.white,
        title: const Text(
          'Supervisor Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Owner',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [teal, navy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.engineering_rounded,
                  color: Colors.white,
                  size: 42,
                ),
                const SizedBox(height: 12),
                const Text(
                  'SITE OPERATIONS',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Daily Work Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.ownerDetails['Project Name'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Project: ${widget.ownerDetails['Project Name']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
                if (widget.ownerDetails['Construction Location'] !=
                    null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.ownerDetails['Construction Location']!,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: summaryCard(
                  'Worker Headcount',
                  '$totalWorkers',
                  Icons.groups_rounded,
                  const Color(0xFFDDF5EF),
                  teal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: summaryCard(
                  'Total Salary',
                  '₹${totalSalary.toStringAsFixed(0)}',
                  Icons.payments_rounded,
                  const Color(0xFFE5EEFF),
                  const Color(0xFF1769AA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          sectionTitle('Workforce', Icons.people_alt_rounded),
          const SizedBox(height: 10),
          actionCard(
            'Add Worker Details',
            'Category, headcount and daily wages',
            Icons.person_add_alt_1_rounded,
            addWorker,
          ),
          ...workers.map(
            (worker) => recordCard(
              worker['Category'] ?? 'Worker',
              'Headcount: ${worker['Headcount']}\n'
                  'Daily wage: ₹${worker['Daily Wage']}\n'
                  'Total salary: ₹${worker['Total Salary']}',
              Icons.groups_rounded,
            ),
          ),
          const SizedBox(height: 24),
          sectionTitle(
            'Material Requirements',
            Icons.inventory_2_rounded,
          ),
          const SizedBox(height: 10),
          actionCard(
            'Add Material Request',
            'Item, quantity, date and urgency',
            Icons.add_box_rounded,
            addMaterial,
          ),
          ...materials.map(
            (material) => recordCard(
              material['Item'] ?? 'Material',
              'Quantity: ${material['Quantity']} ${material['Unit']}\n'
                  'Required by: ${material['Required By']}\n'
                  'Urgency: ${material['Urgency']}',
              Icons.inventory_rounded,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 54,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text(
                'Back to Owner Dashboard',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: navy,
                side: const BorderSide(color: navy),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 28, color: teal),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ),
      ],
    );
  }

  Widget summaryCard(
    String title,
    String value,
    IconData icon,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: foreground),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      color: Colors.white,
      elevation: 1,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFDDF5EF),
          child: Icon(icon, color: teal),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 17),
        onTap: onTap,
      ),
    );
  }

  Widget recordCard(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE5EEFF),
          child: Icon(icon, color: navy),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),
      ),
    );
  }
}