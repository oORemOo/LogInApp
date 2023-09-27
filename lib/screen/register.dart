import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'login.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register(BuildContext context) async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        if (!validator.email(emailController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('รูปแบบอีเมลไม่ถูกต้อง'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('กรุณาใส่อีเมลและรหัสผ่าน'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogInScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('เกิดข้อผิดพลาดในการลงทะเบียน: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('อีเมลนี้ถูกใช้งานแล้วในบัญชีผู้ใช้อื่น'),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('เกิดข้อผิดพลาดในการลงทะเบียน: ${e.message}'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาดในการลงทะเบียน: $e'),
            duration: Duration(seconds: 3),
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
        child: Form(
          key: _formKey, // นี่คือส่วนที่คุณต้องเพิ่มเข้าไป
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
                ),
              ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่รหัสผ่าน';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณายืนยันรหัสผ่าน';
                    }
                    if (value != passwordController.text) {
                      return 'รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    register(context);
                  }
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // ระบุสีพื้นหลังของปุ่มเป็นสีน้ำเงิน
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

