

import 'package:booking/views/bottomnavigation.dart';

import 'package:flutter/material.dart';
import '../ models/doctor.dart';

import 'package:intl/intl.dart'; // For formatting the date and getting the day of the week

class AppointmentScreen extends StatefulWidget {
  final Doctor doctor;

  AppointmentScreen({required this.doctor});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int selectedMonth = DateTime.now().month; // Default to current month
  List<int> daysInMonth = [];
  List<String> dayOfWeekLabels = [];

  // Example visiting hours
  final List<String> timeSlots = [
    "9 AM", "10 AM", "11 AM", "12 PM", "1 PM",
    "2 PM", "3 PM", "4 PM", "5 PM", "6 PM"
  ];

  String? selectedDate;
  String? selectedTime;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mrdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateDaysInMonth(selectedMonth);
  }

  // Get the days and the corresponding weekday for the selected month
  void _updateDaysInMonth(int month) {
    final now = DateTime(DateTime.now().year, month, 1); // First day of the selected month
    final daysInMonthCount = DateTime(now.year, month + 1, 0).day; // Get number of days in the month
    final List<int> days = List.generate(daysInMonthCount, (index) => index + 1);
    final List<String> dayLabels = days.map((day) {
      DateTime currentDate = DateTime(now.year, month, day);
      return DateFormat('EEEE').format(currentDate); // Get the day of the week
    }).toList();

    setState(() {
      daysInMonth = days;
      dayOfWeekLabels = dayLabels;
    });
  }

  // Select Date
  void _selectDate(int day) {
    setState(() {
      selectedDate = '${DateFormat('dd MMMM').format(DateTime(DateTime.now().year, selectedMonth, day))}';
    });
  }

  // Select Time
  void _selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }


  void _confirmAppointment() {
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment successfully booked!'),
        duration: Duration(seconds: 1), // Show the message for 2 seconds
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Navigate to the Dashboard after a delay
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bottomnavigation(),
        ),
      );
    });
  }




  @override
  Widget build(BuildContext context) {
    // Make layout responsive using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous page when the back button is pressed

        return true; // Prevent the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Row(
            children: [
              Text('Appointment', style: TextStyle(fontSize: 22)),
              SizedBox(width: 60),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name Section
                Center(
                  child: Container(
                    height: 80,
                    width: screenWidth - 40,
                    padding: EdgeInsets.all(16),
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
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            widget.doctor.name,
      
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
      
                            widget.doctor.role,
                            style: TextStyle(fontSize: 16, ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
      
                // Schedules Section with Month Picker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedules',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showMonthPicker(context);
                        },
                        child: Text(
                          '${DateFormat('MMMM').format(DateTime(0, selectedMonth))} >',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
      
                // Days Selection
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: daysInMonth.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _selectDate(daysInMonth[index]),
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: selectedDate == '${DateFormat('dd MMMM').format(DateTime(DateTime.now().year, selectedMonth, daysInMonth[index]))}' ? Colors.blue[100] : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  daysInMonth[index].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dayOfWeekLabels[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
      
                // Visit Hours Section (Time Slot Selection)
                Text(
                  'Visit Hours',
                  style: TextStyle(fontSize: 22, color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _selectTime(timeSlots[index]),
                        child: Container(
                          width: 90,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: selectedTime == timeSlots[index] ? Colors.blue[100] : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              timeSlots[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      
                SizedBox(height: 20),
                SizedBox(height: 20),
                Text(
                  'Patient',
                  style: TextStyle(fontSize: 22, color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
      // Phone Number Text Field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: InputBorder.none, // Remove the default border
                    ),
                  ),
                ),
      
                SizedBox(height: 10),
                Container(
                  width: 360,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the Row contents
                    children: [
                      Text(
                        'MRD24',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'John',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {

                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // This changes the text color of the button to red
                        ),
                        child: SelectableText(
                          'select', // The text is now selectable
                          style: TextStyle(
                            color: Colors.black, // The color of the text is red
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  width: 360,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the Row contents
                    children: [
                      Text(
                        'MRD25',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'John Smith',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
      // Define your button's action here
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // This changes the text color of the button to red
                        ),
                        child: SelectableText(
                          'select', // The text is now selectable
                          style: TextStyle(
                            color: Colors.black, // The color of the text is red
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirm Appointment Button
                Center(
                  child: TextButton(
                    onPressed: _confirmAppointment,
      
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding: EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
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

  // Show Month Picker Dialog
  void _showMonthPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Month'),
          children: List.generate(12, (index) {
            final monthName = DateFormat('MMMM').format(DateTime(0, index + 1)); // Get month name
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  selectedMonth = index + 1;
                  _updateDaysInMonth(selectedMonth);
                });
              },
              child: Text(monthName),
            );
          }),
        );
      },
    );
  }
}