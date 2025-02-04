import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/packages/garage/garage_manager.dart';
import 'package:flutter_basics_samples/packages/garage/models/vehicle.dart';

class GaragePage extends StatelessWidget {
  const GaragePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garage'),
      ),
      body: const VehiclesList(),
    );
  }
}

class VehiclesList extends StatelessWidget {
  const VehiclesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: GarageManager.instance.getVehicles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${snapshot.error}'),
              ],
            ),
          );
        }

        final vehicles = snapshot.data ?? [];
        
        if (vehicles.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_car_outlined, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No vehicles found'),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text(vehicle.licensePlate),
              subtitle: Text('Year: ${vehicle.year}'),
              onTap: () {
                // Handle vehicle selection
              },
            );
          },
        );
      },
    );
  }
}
