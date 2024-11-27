
import 'package:flutter/material.dart';







import '../ controllers/database_helper.dart';

import 'bottomnavigation.dart';
import 'package:flutter/material.dart';



// Replace with the actual path to your InitialScreen page

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState() {
      super.initState();
      _navigateToNextScreen();
   }

   Future<void> _navigateToNextScreen() async {
      try {
         // Simulate splash screen delay
         await Future.delayed(Duration(seconds: 1));

         // Check login status
         bool isLoggedIn = await DatabaseHelper.instance.isLoggedIn();

         // Navigate based on login status
         if (isLoggedIn) {
            Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => Bottomnavigation()),
            );
         } else {
            Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => InitialScreen()),
            );
         }
      } catch (e) {
         print('Error during navigation: $e');
         Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InitialScreen()),
         );
      }
   }

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         backgroundColor: Colors.blue[700],
         body: Center(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  Image.asset(
                     'assets/logo.png', // Replace with the path to your logo
                     height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                     'Booking App', // Replace with your app's name
                     style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                     ),
                  ),
               ],
            ),
         ),
      );
   }
}



// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToNextScreen();
//   }
//
//   Future<void> _navigateToNextScreen() async {
//     // Simulate a delay for splash screen visibility
//     await Future.delayed(Duration(seconds: 3));
//
//     // Check login status from SQLite database
//     bool isLoggedIn = await DatabaseHelper().isLoggedIn();
//
//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) =>  Bottomnavigation()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) =>InitialScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[700],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/logo.png',
//               height: 150,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Booking App',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



class InitialScreen extends StatelessWidget {

   @override


   Widget build(BuildContext context) {
   double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;
   Future.delayed(Duration(seconds: 15), () {
   Navigator.pushReplacementNamed(context, '/signin');
   });

   return Scaffold(
   body: SingleChildScrollView(
   child: Column(
   crossAxisAlignment: CrossAxisAlignment.center,
   children: [
   // Image Section
   Container(
   height: screenHeight * 0.65, // Adjust height proportionally
   width: screenWidth, // Full screen width
   child: Image.asset(
   'assets/splash1.png', // Replace with your image asset path
   fit: BoxFit.cover, // Makes image cover the container
   ),
   ),
   SizedBox(height: screenHeight * 0.02), // Responsive spacing
   // First Text: App Name or Logo Text
   Text(
   'Book Appointment',
   textAlign: TextAlign.center,
   style: TextStyle(
   fontSize: screenWidth * 0.1, // Responsive font size
   fontWeight: FontWeight.bold,
   color: Colors.blue[800],
   ),
   ),
   SizedBox(height: screenHeight * 0.01), // Responsive spacing
   // Second Text: App Tagline or Description
   Padding(
   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
   child: Text(
   "Book Doctor's Appointment For the patients",
   textAlign: TextAlign.center,
   style: TextStyle(
   fontSize: screenWidth * 0.06, // Responsive font size
   color: Colors.blueGrey,
   ),
   ),
   ),
   SizedBox(height: screenHeight * 0.03), // Responsive spacing
   // Get Started Button
   Center(
   child: TextButton(
   onPressed: () {
   Navigator.pushReplacementNamed(context, '/signin');
   },
   style: TextButton.styleFrom(
   backgroundColor: Colors.blue[800],
   padding: EdgeInsets.symmetric(
   horizontal: screenWidth * 0.25, // Responsive width
   vertical: screenHeight * 0.02, // Responsive height
   ),
   shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(10),
   ),
   ),
   child: Text(
   'Get Started',
   style: TextStyle(
   color: Colors.white,
   fontSize: screenWidth * 0.05, // Responsive font size
   ),
   ),
   ),
   ),
   ],
   ),
   ),
   );
   }
   }
