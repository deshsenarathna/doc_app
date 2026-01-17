import 'package:flutter/material.dart';
import '../models/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool isLoading = false;
  String role = 'patient'; // default
  List<String> upcomingAppointments = []; // simple mock data
  String welcomeMessage = '';

  // Initialize data based on role
  void init(String userRole) {
    role = userRole;
    isLoading = true;
    notifyListeners();

    // Simulate fetching data
    Future.delayed(const Duration(seconds: 1), () {
      if (role == 'patient') {
        upcomingAppointments = ['Dr. Smith - 10:00 AM', 'Dr. Lee - 3:00 PM'];
        welcomeMessage = 'Hello, Patient!';
      } else {
        upcomingAppointments = ['Patient A - 9:00 AM', 'Patient B - 11:00 AM'];
        welcomeMessage = 'Hello, Doctor!';
      }
      isLoading = false;
      notifyListeners();
    });
  }
}
