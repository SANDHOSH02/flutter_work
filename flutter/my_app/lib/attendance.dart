import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  int _selectedIndex = 1;
  String? selectedClass;
  final List<String> studentNames = ['Naveen', 'Sri hari', 'Santhosh', 'Pranav', 'Tech'];
  final List<String> classes = ['IT', 'AI', 'CSE', 'ECE'];
  final Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();
    for (var name in studentNames) {
      attendance[name] = false;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/main.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'John Doe',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Staff - Teacher',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/bell.svg',
                        color: Colors.deepPurple,
                        height: 24,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: classes.map((className) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedClass = className;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedClass == className ? Colors.deepPurple : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      child: Text(
                        className,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              selectedClass == null
                  ? const Center(child: Text("Select a class to view attendance."))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          itemCount: studentNames.length,
                          itemBuilder: (context, index) {
                            final studentName = studentNames[index];
                            return _buildAttendanceRecord(studentName, attendance[studentName]!);
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              color: _selectedIndex == 0 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/menu.svg',
              color: _selectedIndex == 1 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/request.svg',
              color: _selectedIndex == 2 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile.svg',
              color: _selectedIndex == 3 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord(String studentName, bool isPresent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            studentName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              isPresent ? Icons.check_circle : Icons.cancel,
              color: isPresent ? Colors.green : Colors.red,
            ),
            onPressed: () {
              setState(() {
                attendance[studentName] = !isPresent;
              });
            },
          ),
        ],
      ),
    );
  }
}
