import 'package:flutter/material.dart';
import 'log_in.dart'; // import หน้า log_in.dart
import 'register.dart'; // import หน้า Register.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // เมื่อคลิกที่ปุ่ม "Log In" ให้ไปที่หน้า log_in.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInScreen()),
                );
              },
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(
                    255, 243, 243, 243), // สีพื้นหลังของปุ่ม
                textStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 0, 0, 0)), // สีของข้อความบนปุ่ม
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: 30), // ปรับขนาดของปุ่ม
              ),
            ),
            SizedBox(height: 20), // เพิ่ม SizedBox เพื่อเพิ่มช่องว่างระหว่างปุ่ม
            ElevatedButton(
              onPressed: () {
                // เมื่อคลิกที่ปุ่ม "Register" ให้ไปที่หน้า Register.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(
                    255, 248, 248, 248), // สีพื้นหลังของปุ่ม
                textStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 0, 0, 0)), // สีของข้อความบนปุ่ม
                padding: EdgeInsets.symmetric(
                    horizontal: 80, vertical: 30), // ปรับขนาดของปุ่ม
              ),
            ),
          ],
        ),
      ),
    );
  }
}
