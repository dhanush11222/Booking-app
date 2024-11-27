import 'package:booking/views/dashboard_screen.dart';
import 'package:booking/views/doctor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  // Current index of the BottomNavigationBar
  int _selectedIndex = 0;

  // List of widget screens for each tab
  final List<Widget> _screens = [
    DashboardScreen(), // Home tab now navigates to DashboardScreen
    DoctorListScreen(), // Screen for Doctor List
    KnotsPage(),
    ProfilePage(), // Placeholder for Profile screen
  ];
  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      // If not on the home tab, go back to the home tab
      setState(() {
        _selectedIndex = 0;
      });
      return false; // Prevent the app from exiting
    } else {
      // Show a confirmation dialog
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
              child: Text('Exit'),
            ),
          ],
        ),
      );
      return shouldExit ?? false; // Exit if the user confirms
    }
  }
  // Update the selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Row(
                  children: [
                    Icon(Icons.home, color: Colors.black), // Home icon
                    SizedBox(width: 20), // Space between icon and text
                    Text('Home', style: TextStyle(color: Colors.black)), // Text next to the icon
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black), // Settings icon
                    SizedBox(width: 10), // Space between icon and text
                    Text('Settings', style: TextStyle(color: Colors.black)), // Text next to the icon
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3; // Assuming settings is on the Profile tab
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: _screens[_selectedIndex], // Show selected screen

        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            // Home Tab Item
            BottomNavigationBarItem(
              icon: _buildLabelWithIcon(Icons.home, 0, 'Home'),
              label: '', // Label is now empty, handled by _buildLabelWithIcon
            ),
            // Doctor List Tab Item
            BottomNavigationBarItem(
              icon: _buildLabelWithIcon(Icons.local_hospital, 1, 'Doctor'),
              label: '', // Label is now empty, handled by _buildLabelWithIcon
            ),
            // Notes Tab Item
            BottomNavigationBarItem(
              icon: _buildLabelWithIcon(Icons.note, 2, 'Notes'),
              label: '', // Label is now empty, handled by _buildLabelWithIcon
            ),
            // Profile Tab Item
            BottomNavigationBarItem(
              icon: _buildLabelWithIcon(Icons.account_circle, 3, 'Profile'),
              label: '', // Label is now empty, handled by _buildLabelWithIcon
            ),
          ],
        ),
      ),
    );
  }

  // Custom widget for round icon


  Widget _buildLabelWithIcon(IconData icon, int index, String label) {
    return InkWell(
      onTap: () {
        _onItemTapped(index); // Trigger tap to change state
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Smooth animation
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        width: _selectedIndex == index ? 120 : 50, // Adjust width dynamically
        height: 50, // Fixed height
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.blue[700] : Colors.transparent,
          borderRadius: BorderRadius.circular(25), // Rounded edges
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.white : Colors.black,
              size: _selectedIndex == index ? 28 : 24, // Adjust size
            ),
            if (_selectedIndex == index) // Show text only when selected
              Flexible( // Ensures text fits without overflow
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Avoid overflow
                    maxLines: 1, // Ensure single-line text
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


}


class KnotsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Knots Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}