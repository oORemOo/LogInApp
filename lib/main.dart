import 'screen/home.dart'; // นำเข้าไฟล์ HOME.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // เพิ่มนี้

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAMS8AGbs5z8ZePZk-_kME286rPetkJ20g",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "task1-bb623",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "65476767063",
      appId: "1:65476767063:android:2ae96608a28b076b67e212",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), // กำหนด HomeScreen() เป็นหน้าหลัก
    );
  }
}
