import 'package:flutter/material.dart';
import '../supervisor/supervisor_dashboard_page.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({super.key, required this.details});

  final Map<String, String> details;

  static const Color navy = Color(0xFF17324D);
  static const Color blue = Color(0xFF2478D4);
  static const Color background = Color(0xFFF4F7FB);

  String getValue(String key) {
    return details[key]?.trim().isNotEmpty == true
        ? details[key]!
        : 'Not provided';
  }

  double getNumber(String key) {
    return double.tryParse(details[key] ?? '') ?? 0;
  }

  String money(double amount) => '₹${amount.toStringAsFixed(0)}';

  @override
  Widget build(BuildContext context) {
    final budget = getNumber('Estimated Budget');
    final spent = getNumber('Amount Spent');
    final remaining = (budget - spent).clamp(0.0, double.infinity);
    final progress = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Owner Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project overview
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [navy, Color(0xFF285D87)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.apartment_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PROJECT OVERVIEW',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getValue('Project Name'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          getValue('Construction Location'),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      overviewTag(
                        Icons.home_work_outlined,
                        getValue('Building Type'),
                      ),
                      overviewTag(
                        Icons.layers_outlined,
                        '${getValue('Number of Floors')} Floors',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),
            sectionTitle('Budget Summary', 'Track your project expenses'),

            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 600;
                final cardWidth = wide
                    ? (constraints.maxWidth - 14) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: budgetCard(
                        'Total Budget',
                        money(budget),
                        Icons.account_balance_wallet_outlined,
                        const Color(0xFF2478D4),
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: budgetCard(
                        'Amount Spent',
                        money(spent),
                        Icons.trending_up_rounded,
                        const Color(0xFFE58A24),
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: budgetCard(
                        'Remaining Budget',
                        money(remaining),
                        Icons.savings_outlined,
                        const Color(0xFF168B72),
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: budgetCard(
                        'Workers Today',
                        getValue('Workers Today'),
                        Icons.groups_outlined,
                        const Color(0xFF7957C8),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 22),

            // Expense progress
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Budget Usage',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: const Color(0xFFE6EDF5),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(blue),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    budget > 0
                        ? '${(progress * 100).toStringAsFixed(1)}% of budget spent'
                        : 'Enter a valid budget to view progress',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            sectionTitle('Project Details', 'Construction information'),
            const SizedBox(height: 14),

            detailsSection('Project Information', Icons.apartment, [
              detailRow('Owner Name', 'Owner Name', Icons.person_outline),
              detailRow('Building Type', 'Building Type', Icons.home_work_outlined),
              detailRow('Number of Floors', 'Number of Floors', Icons.layers_outlined),
              detailRow(
                'Start Date',
                'Construction Start Date',
                Icons.calendar_today_outlined,
              ),
              detailRow(
                'Expected End Date',
                'Expected End Date',
                Icons.event_outlined,
              ),
            ]),

            const SizedBox(height: 16),

            detailsSection('Expense Details', Icons.receipt_long_outlined, [
              detailRow(
                'Material Expenses',
                'Material Expenses',
                Icons.inventory_2_outlined,
              ),
              detailRow(
                'Labour Expenses',
                'Labour Expenses',
                Icons.engineering_outlined,
              ),
            ]),

            const SizedBox(height: 16),

            detailsSection('Supervisor & Workforce', Icons.groups_outlined, [
              detailRow(
                'Supervisor Name',
                'Supervisor Name',
                Icons.person_outline,
              ),
              detailRow(
                'Supervisor Phone',
                'Supervisor Phone',
                Icons.phone_outlined,
              ),
              detailRow(
                'Workers Present',
                'Workers Present',
                Icons.how_to_reg_outlined,
              ),
              detailRow(
                'Workers Absent',
                'Workers Absent',
                Icons.person_off_outlined,
              ),
            ]),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.engineering_outlined),
                label: const Text(
                  'Open Supervisor Dashboard',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SupervisorDashboardPage(
                        ownerDetails: details,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget overviewTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ],
    );
  }

  Widget budgetCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EDF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: navy,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EDF3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: blue),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          ...children,
        ],
      ),
    );
  }

  Widget detailRow(String label, String key, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              getValue(key),
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: navy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}