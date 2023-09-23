import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'log_in.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register(BuildContext context) async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // การลงทะเบียนสำเร็จ ให้กลับไปที่หน้า log_in.dart
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      } else {
        // รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน'),
            duration: Duration(seconds: 3), // ระยะเวลาแสดงข้อความ
          ),
        );
      }
    } catch (e) {
      print('เกิดข้อผิดพลาดในการลงทะเบียน: $e');
      if (e is FirebaseAuthException) {
        // กรณีเกิดข้อผิดพลาดจาก Firebase Authentication
        if (e.code == 'email-already-in-use') {
          // อีเมลถูกใช้งานแล้วในบัญชีผู้ใช้อื่น
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('อีเมลนี้ถูกใช้งานแล้วในบัญชีผู้ใช้อื่น'),
              duration: Duration(seconds: 3), // ระยะเวลาแสดงข้อความ
            ),
          );
        } else {
          // กรณีข้อผิดพลาดอื่นๆ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('เกิดข้อผิดพลาดในการลงทะเบียน: ${e.message}'),
              duration: Duration(seconds: 3), // ระยะเวลาแสดงข้อความ
            ),
          );
        }
      } else {
        // กรณีข้อผิดพลาดอื่นๆ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาดในการลงทะเบียน: $e'),
            duration: Duration(seconds: 3), // ระยะเวลาแสดงข้อความ
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                register(context); // เรียกใช้ฟังก์ชัน register เมื่อปุ่มถูกคลิก
              },
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
