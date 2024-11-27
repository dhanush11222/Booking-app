
import 'package:booking/views/appointment_screen.dart';
import 'package:flutter/material.dart';
// Correct import path

import 'package:booking/ models/doctor.dart'; // Adjust based on the actual path.

import '../ models/doctor.dart';



class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final List<Doctor> _doctors = [
    Doctor(name: 'Dr. John Doe', role: 'Senior Doctor', timing: '9:00 AM - 5:00 PM'),
    Doctor(name: 'Dr. Jane Smith', role: 'Junior Doctor', timing: '10:00 AM - 6:00 PM'),
    Doctor(name: 'Dr. Alice Brown', role: 'Senior Doctor', timing: '8:30 AM - 4:30 PM'),
    Doctor(name: 'Dr. Robert Taylor', role: 'Pediatrician', timing: '11:00 AM - 7:00 PM'),
    Doctor(name: 'Dr. Emily White', role: 'Dermatologist', timing: '9:00 AM - 4:00 PM'),
    Doctor(name: 'Dr. Michael Green', role: 'Cardiologist', timing: '8:00 AM - 3:00 PM'),
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Row(
          children: [
            Text('Doctor List', style: TextStyle(fontSize: 22)),
            SizedBox(width: 80),
            Image.asset(
              'assets/logo.png', // Replace with your logo's path
              height: 80,
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Doctors...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return _buildDoctorContainer(doctor, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorContainer(Doctor doctor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  doctor.role,
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to the AppointmentScreen with the selected doctor instance
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentScreen(doctor: doctor),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    doctor.timing,
                    style: TextStyle(fontSize: 14, color: Colors.blue[800]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

