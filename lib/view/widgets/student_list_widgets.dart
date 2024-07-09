import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getxstydentdatabse/model/student.dart';

class StudentImageContainerWidget extends StatelessWidget {
  const StudentImageContainerWidget({
    super.key,
    required this.student,
    required this.height,
    required this.width,
  });
  final StudentModel student;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: FileImage(File(student.imageUrl)), fit: BoxFit.cover),
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
