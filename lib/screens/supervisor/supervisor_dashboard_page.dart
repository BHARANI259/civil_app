import 'package:flutter/material.dart';
import 'site_work_page.dart';
import 'material_page.dart';

class SupervisorDashboardPage extends StatelessWidget {
  const SupervisorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Supervisor Dashboard'),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 15),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _siteHeader(),
          const SizedBox(height: 18),
          _progressCard(),
          const SizedBox(height: 20),

          const Text(
            'Today at Site',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              _stat('Workers', '18/20', Icons.people),
              _stat('Tasks', '3/5', Icons.task_alt),
              _stat('Issues', '2', Icons.warning_amber),
            ],
          ),

          const SizedBox(height: 20),

          _menuButton(
            context,
            'Today\'s Site Work',
            'Manage construction tasks and attendance',
            Icons.construction,
            const SiteWorkPage(),
          ),

          _menuButton(
            context,
            'Material Management',
            'Check and request construction materials',
            Icons.inventory_2_outlined,
            const MaterialManagementPage(),
          ),

          const SizedBox(height: 15),

          const Text(
            'Site Safety',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.health_and_safety,
                size: 35,
              ),
              title: const Text(
                'Safety Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'All workers have safety equipment',
              ),
              trailing: const Icon(
                Icons.check_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _siteHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1769AA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONSTRUCTION SITE',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Dharapuram Building Project',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 17,
              ),
              SizedBox(width: 5),
              Text(
                'Dharapuram, Tamil Nadu',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overall Progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '45%',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const LinearProgressIndicator(
              value: 0.45,
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Construction work is in progress',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, size: 25),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: 25,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }
}