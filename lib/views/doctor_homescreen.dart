import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context, listen: false);
    // Initialize for doctor
    vm.init('doctor');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Home'),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vm.welcomeMessage, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Today\'s Appointments:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.upcomingAppointments.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(vm.upcomingAppointments[index]),
                          trailing: ElevatedButton(
                            child: const Text('Complete'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Mark as completed')),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
