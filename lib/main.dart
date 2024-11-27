import 'package:booking/views/bottomnavigation.dart';
import 'package:booking/views/doctor_list_screen.dart';
import 'package:booking/views/signup.dart';
import 'package:flutter/material.dart';
import 'views/splash_screen.dart';
import 'views/sign_in_screen.dart';
import 'views/dashboard_screen.dart';
import 'views/doctor_list_screen.dart';
import 'views/appointment_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (ctx) => SplashScreen(),
        '/signin': (ctx) => SignInScreen(),
        '/SignUp': (ctx) => SignUpScreen(),
        '/dashboard': (ctx) => DashboardScreen(),
        '/doctor_list': (ctx) => DoctorListScreen(),
        // '/appointment': (ctx) => AppointmentScreen(),
      },
    );
  }
}
/*import 'package:booking/views/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage to check login state

import 'views/splash_screen.dart';
import 'views/sign_in_screen.dart';
import 'views/signup.dart';
import 'views/dashboard_screen.dart';
import 'views/doctor_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define routes
      routes: {
        '/signin': (ctx) => SignInScreen(),
        '/SignUp': (ctx) => SignUpScreen(),
        '/Bottom': (ctx) => Bottomnavigation(),
        '/dashboard': (ctx) => DashboardScreen(),
        '/doctor_list': (ctx) => DoctorListScreen(),
      },
      // Use FutureBuilder to determine the first screen based on login status
      home: FutureBuilder(
        future: _checkLoginStatus(), // Future to check login status
        builder: (ctx, snapshot) {
          // While checking the login status, show splash screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(); // Splash screen while checking login status
          }

          // Once login status is determined, navigate accordingly
          if (snapshot.hasData && snapshot.data == true) {
            return Bottomnavigation(); // If logged in, go to Dashboard
          } else {
            return SignInScreen(); // If not logged in, go to SignIn screen
          }
        },
      ),
    );
  }

  // Method to check if user is logged in or not
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve login status, assume false if not found
    return prefs.getBool('isLoggedIn') ?? false;
  }
}*/

