import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regexed_validator/regexed_validator.dart'; // เพิ่ม package นี้

import 'register.dart';
import 'screen1.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> logIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // ตรวจสอบผู้ใช้ปัจจุบันหลังจากล็อกอิน
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // ล็อกอินสำเร็จ ให้นำผู้ใช้ไปยังหน้า Screen1
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Screen1()),
        );
      } else {
        print('ไม่พบผู้ใช้หลังจากล็อกอิน');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาดในการล็อกอิน: $e');
      // แสดงแจ้งเตือนผู้ใช้เมื่อเกิดข้อผิดพลาด
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ไม่สามารถล็อกอินได้'),
          duration: Duration(seconds: 3), // ระยะเวลาแสดงข้อความ
          action: SnackBarAction(
            label: 'ปิด',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        leading: Icon(Icons.login),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null && !validator.email(value)) {
                      return 'รูปแบบอีเมลไม่ถูกต้อง';
                    }
                    return null;
                  },
                )),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                logIn(context); // เรียกใช้ฟังก์ชัน logIn เมื่อปุ่มถูกคลิก
              },
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}

