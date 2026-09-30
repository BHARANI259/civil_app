import 'package:flutter/material.dart';

class SiteWorkPage extends StatelessWidget {
  const SiteWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Site Work'),
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Work Progress',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          _task(
            'Foundation Work',
            'Completed',
            Icons.check_circle,
          ),

          _task(
            'Column Work - Floor 1',
            'In Progress',
            Icons.construction,
          ),

          _task(
            'Brick Work',
            'Pending',
            Icons.pending,
          ),

          _task(
            'Electrical Work',
            'Pending',
            Icons.electrical_services,
          ),

          const SizedBox(height: 20),

          const Text(
            'Worker Attendance',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Card(
            child: Column(
              children: [
                _row('Total Workers', '20'),
                _row('Present', '18'),
                _row('Absent', '2'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Today\'s Site Update',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Foundation work completed. '
                'Column work started on the first floor.',
              ),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.update),
              label: const Text('Submit Daily Update'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _task(
    String title,
    String status,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon, size: 19),
        ),
        title: Text(title),
        trailing: Text(status),
      ),
    );
  }

  Widget _row(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}