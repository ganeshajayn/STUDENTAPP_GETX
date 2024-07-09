import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstydentdatabse/view/student_list_screen.dart/student_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: StudentListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
