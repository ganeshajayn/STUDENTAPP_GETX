import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstydentdatabse/model/student.dart';
import 'package:getxstydentdatabse/services/functions.dart';
import 'package:getxstydentdatabse/utils/constants.dart';
import 'package:getxstydentdatabse/view/widgets/app_bar_widget.dart';
import 'package:getxstydentdatabse/view/widgets/circle_avatar_widget.dart';
import 'package:getxstydentdatabse/view/widgets/text_form_widgetr.dart';
import 'package:getxstydentdatabse/viewmodel/student_controller.dart';
import 'package:image_picker/image_picker.dart';

final StudentController studentsController = Get.put(StudentController());

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController placeController = TextEditingController();
    TextEditingController phoneNoController = TextEditingController();
    TextEditingController guardianNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    RxString pickedimage = RxString('');

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: AppBarWidget(
          onTapLeft: () {
            Get.back();
          },
          title: 'Enter the details',
          lefticon: Icons.arrow_back,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    String? imagePath =
                        await studentsController.pickImage(ImageSource.gallery);
                    pickedimage.value = imagePath ?? '';
                  },
                  child:
                      CircleAvatarWidget(pickedimage: pickedimage, radius: 80),
                ),
              ),
              Constants().kheight20,
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'please enter a valid name';
                          }
                          return null;
                        },
                        prefixicon: Icons.person,
                        controller: nameController,
                        hintText: 'Enter the name',
                        labelText: 'Name',
                        inputType: TextInputType.name,
                      ),
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) >= 120 ||
                              int.parse(value) <= 0) {
                            return 'please enter a valid age';
                          }
                          return null;
                        },
                        prefixicon: Icons.numbers,
                        controller: ageController,
                        hintText: 'Enter the age',
                        labelText: 'Age',
                        inputType: TextInputType.number,
                      ),
                      TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid department';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: departmentController,
                          hintText: 'Enter the department',
                          labelText: 'Department',
                          inputType: TextInputType.text),
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'please enter a valid place';
                          }
                          return null;
                        },
                        prefixicon: Icons.location_city,
                        controller: placeController,
                        hintText: 'Enter the place',
                        labelText: 'Place',
                        inputType: TextInputType.text,
                      ),
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10) {
                            return 'please enter a valid phone no';
                          }
                          return null;
                        },
                        prefixicon: Icons.phone,
                        controller: phoneNoController,
                        hintText: 'Enter the phone number',
                        labelText: 'Contact Number',
                        inputType: TextInputType.number,
                      ),
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'please enter a valid name';
                          }
                          return null;
                        },
                        prefixicon: Icons.person,
                        controller: guardianNameController,
                        hintText: 'Enter the name of the Guardian',
                        labelText: 'Guardian Name',
                        inputType: TextInputType.name,
                      ),
                      Constants().kheight10,
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(5),
                              backgroundColor: MaterialStatePropertyAll(
                                  Constants().appColor)),
                          onPressed: () {
                            // if every field is validated
                            if (formKey.currentState!.validate() &&
                                pickedimage.isNotEmpty) {
                              studentsController.addStudent(StudentModel(
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  department: departmentController.text,
                                  place: placeController.text,
                                  phoneNumber:
                                      int.parse(phoneNoController.text),
                                  guardianName: guardianNameController.text,
                                  imageUrl: pickedimage.string));
                              // clearing the fields after saving
                              nameController.clear();
                              ageController.clear();
                              departmentController.clear();
                              placeController.clear();
                              phoneNoController.clear();
                              guardianNameController.clear();
                              pickedimage.value = '';
                              print(
                                  'form is validated ${studentsController.students}');
                              snackBarFunction(
                                  title: 'Success',
                                  subtitle: 'Submitted Successfully',
                                  backgroundColor: Colors.green,
                                  animationDuration:
                                      const Duration(milliseconds: 2000),
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                            // if the image is not picked up
                            else if (pickedimage.isEmpty) {
                              snackBarFunction(
                                  title: 'Submission Failed',
                                  subtitle: 'Please select an image',
                                  backgroundColor: Colors.red,
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              print('not valid');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Constants().whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}

class GoogleFonts {}
