import 'package:booking/%20controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../ controllers/database_helper.dart';


class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                child: Image.asset(
                  'assets/signin.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Sign in to book a doctor appointment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Email TextField
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Enter the user name',
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Password TextField
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter the Password',
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
                obscureText: true,
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Sign In Button
              Center(
                child: TextButton(
                  onPressed: () async {
                    // Validate the credentials
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in both fields')),
                      );
                      return;
                    }

                    try {
                      // Fetch user data from SQLite by email
                      List<Map<String, dynamic>> user =
                      await DatabaseHelper.instance.getUserByEmail(email);

                      if (user.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No user found with this email')),
                        );
                      } else {
                        // Check if the password matches
                        if (user[0]['password'] == password) {
                          // Navigate to dashboard if credentials are correct
                          Navigator.pushReplacementNamed(context, '/Bottom');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Incorrect password')),
                          );
                        }
                      }
                    } catch (e) {
                      print('Error: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred. Please try again later.')),
                      );
                    }
                  },

                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.3,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.055,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Sign Up Link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SignUp');
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:booking/%20controllers/auth_controller.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// // AuthController to handle Firebase Authentication
// // class AuthController {
// //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// //
// //   Future<bool> signIn({required String email, required String password}) async {
// //     try {
// //       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //       return userCredential.user != null;  // If user is non-null, sign-in is successful
// //     } catch (e) {
// //       print("Sign-in failed: $e");
// //       return false;  // Sign-in failed
// //     }
// //   }
// // }
// //
// // class SignInScreen extends StatelessWidget {
// //   final AuthController _authController = AuthController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double screenHeight = MediaQuery.of(context).size.height;
// //     double screenWidth = MediaQuery.of(context).size.width;
// //
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               // Responsive Image Container
// //               Container(
// //                 height: screenHeight * 0.5, // 50% of screen height
// //                 width: screenWidth, // Full width
// //                 child: Image.asset(
// //                   'assets/signin.png', // Replace with your image path
// //                   fit: BoxFit.cover, // Makes image cover the container
// //                 ),
// //               ),
// //
// //               // Sign In Text
// //               Text(
// //                 'Sign In',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: screenWidth * 0.09, // Font size proportional to width
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blue[800],
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.01),
// //               Text(
// //                 'Sign in to book a doctor appointment',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontSize: screenWidth * 0.05, // Font size proportional to width
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blueGrey,
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.03), // Responsive spacing
// //
// //               // Email TextField
// //               TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Enter your email',
// //                   border: OutlineInputBorder(),
// //                   fillColor: Colors.grey[200], // Light gray background
// //                   filled: true,
// //                 ),
// //                 style: TextStyle(fontSize: screenWidth * 0.04), // Font size
// //               ),
// //               SizedBox(height: screenHeight * 0.01), // Responsive spacing
// //
// //               // Password TextField
// //               TextField(
// //                 controller: passwordController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Enter your password',
// //                   border: OutlineInputBorder(),
// //                   fillColor: Colors.grey[200], // Light gray background
// //                   filled: true,
// //                 ),
// //                 obscureText: true,
// //                 style: TextStyle(fontSize: screenWidth * 0.04), // Font size
// //               ),
// //               SizedBox(height: screenHeight * 0.03), // Responsive spacing
// //
// //               // Sign In Button
// //               Center(
// //                 child: TextButton(
// //                   onPressed: () async {
// //                     // Firebase Authentication Logic
// //                     bool isSuccess = await _authController.signIn(
// //                       email: emailController.text,
// //                       password: passwordController.text,
// //                     );
// //                     if (isSuccess) {
// //                       // Navigate to dashboard if successful
// //                       Navigator.pushReplacementNamed(context, '/dashboard');
// //                     } else {
// //                       // Show error message if sign-in fails
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         SnackBar(content: Text('Sign in failed. Check your credentials.')),
// //                       );
// //                     }
// //                   },
// //                   style: TextButton.styleFrom(
// //                     backgroundColor: Colors.blue[800],
// //                     padding: EdgeInsets.symmetric(
// //                       horizontal: screenWidth * 0.3, // Button width
// //                       vertical: screenHeight * 0.02, // Button height
// //                     ),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                   child: Text(
// //                     'Get Started',
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: screenWidth * 0.055, // Font size proportional
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.02), // Responsive spacing
// //
// //               // Sign Up Link
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/SignUp');
// //                 },
// //                 child: Text(
// //                   "Don't have an account? Sign Up",
// //                   style: TextStyle(
// //                     color: Colors.blue,
// //                     fontSize: screenWidth * 0.04, // Font size proportional
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
