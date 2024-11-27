
import 'package:booking/views/bottomnavigation.dart';
import 'package:flutter/material.dart';


import '../ controllers/database_helper.dart';



class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  child: Image.asset(
                    'assets/signin.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Create an account to book appointments',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Name TextField
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
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
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  obscureText: true,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Confirm Password TextField
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  obscureText: true,
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Sign Up Button
                Center(
                  child: TextButton(
                    onPressed: () async {
                      String name = nameController.text;
                      String email = emailController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      // Validation
                      if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields')),
                        );
                        return;
                      }

                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match')),
                        );
                        return;
                      }

                      // Insert user into SQLite database
                      bool isSuccess = await DatabaseHelper.instance.insertUser({
                        'name': name,
                        'email': email,
                        'password': password,
                      });

                      if (isSuccess) {
                        // Navigate to dashboard if sign-up is successful
                        Navigator.pushReplacementNamed(context, '/Bottom');
                      } else {
                        // Show error if sign-up fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sign-up failed. Please try again.')),
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  )

                ),
                SizedBox(height: screenHeight * 0.02),
                // Sign In Link
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    "Already have an account? Sign In",
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
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';



// class SignUpScreen extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // Email validation method
//     bool isValidEmail(String email) {
//       final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
//       return emailRegex.hasMatch(email);
//     }
//
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(screenWidth * 0.04),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: screenHeight * 0.4,
//                   width: screenWidth,
//                   child: Image.asset(
//                     'assets/signin.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Text(
//                   'Sign Up',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.09,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.01),
//                 Text(
//                   'Create an account to book appointments',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.05,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey,
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.03),
//                 // Full Name Field
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name',
//                     border: OutlineInputBorder(),
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                   ),
//                   style: TextStyle(fontSize: screenWidth * 0.04),
//                 ),
//                 SizedBox(height: screenHeight * 0.01),
//                 // Email Address Field
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email Address',
//                     border: OutlineInputBorder(),
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                   ),
//                   style: TextStyle(fontSize: screenWidth * 0.04),
//                 ),
//                 SizedBox(height: screenHeight * 0.01),
//                 // Password Field
//                 TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                   ),
//                   obscureText: true,
//                   style: TextStyle(fontSize: screenWidth * 0.04),
//                 ),
//                 SizedBox(height: screenHeight * 0.01),
//                 // Confirm Password Field
//                 TextField(
//                   controller: confirmPasswordController,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(),
//                     fillColor: Colors.grey[200],
//                     filled: true,
//                   ),
//                   obscureText: true,
//                   style: TextStyle(fontSize: screenWidth * 0.04),
//                 ),
//                 SizedBox(height: screenHeight * 0.03),
//                 Center(
//                   child: TextButton(
//                     onPressed: () async {
//                       // Validate fields
//                       if (nameController.text.trim().isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Please enter your full name.')),
//                         );
//                         return;
//                       }
//
//                       if (!isValidEmail(emailController.text.trim())) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Please enter a valid email address.')),
//                         );
//                         return;
//                       }
//
//                       if (passwordController.text.trim().isEmpty ||
//                           confirmPasswordController.text.trim().isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Password fields cannot be empty.')),
//                         );
//                         return;
//                       }
//
//                       if (passwordController.text != confirmPasswordController.text) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Passwords do not match.')),
//                         );
//                         return;
//                       }
//
//                       if (passwordController.text.length < 6) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Password must be at least 6 characters long.')),
//                         );
//                         return;
//                       }
//
//                       try {
//                         // Attempt signup with Firebase
//                         await _auth.createUserWithEmailAndPassword(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim(),
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Signup successful!')),
//                         );
//                         Navigator.pushReplacementNamed(context, '/dashboard');
//                       } on FirebaseAuthException catch (e) {
//                         String errorMessage;
//                         switch (e.code) {
//                           case 'email-already-in-use':
//                             errorMessage = 'The email address is already in use.';
//                             break;
//                           case 'invalid-email':
//                             errorMessage = 'The email address is badly formatted.';
//                             break;
//                           case 'weak-password':
//                             errorMessage = 'The password is too weak.';
//                             break;
//                           default:
//                             errorMessage = 'An unexpected error occurred: ${e.message}';
//                         }
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(errorMessage)),
//                         );
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('An error occurred. Please try again.')),
//                         );
//                       }
//                     },
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.blue[800],
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.3,
//                         vertical: screenHeight * 0.02,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: screenWidth * 0.055,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/signin');
//                   },
//                   child: Text(
//                     "Already have an account? Sign In",
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: screenWidth * 0.04,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



