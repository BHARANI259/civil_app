import 'package:flutter/material.dart';

class MaterialManagementPage extends StatelessWidget {
  const MaterialManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Management'),
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Available Materials',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          _material(
            'Cement',
            '50 Bags Available',
            Icons.inventory_2,
          ),

          _material(
            'Steel',
            '1.2 Tons Available',
            Icons.linear_scale,
          ),

          _material(
            'Bricks',
            '3000 Pieces Available',
            Icons.grid_4x4,
          ),

          _material(
            'Sand',
            '5 Loads Available',
            Icons.landscape,
          ),

          const SizedBox(height: 20),

          const Text(
            'Material Requests',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Card(
            child: ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Cement Delivery'),
              subtitle: Text('20 bags requested'),
              trailing: Text('Pending'),
            ),
          ),

          const Card(
            child: ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Steel Delivery'),
              subtitle: Text('500 kg requested'),
              trailing: Text('Approved'),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Request Material'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _material(
    String name,
    String amount,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text('Available at site'),
        trailing: Text(amount),
      ),
    );
  }
}