import 'package:flutter/material.dart';
import 'home.dart'; 
import 'attendance.dart';// Import home.dart here


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // Limit max width
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/nscet.png', // Replace with your logo asset path
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A3D62),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'User', child: Text('User')),
                        DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                        DropdownMenuItem(value: 'Guest', child: Text('Guest')),
                      ],
                      onChanged: (value) {
                        // Handle role selection
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 179, 83, 83),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xFF22A6B3),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF0A3D62),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
