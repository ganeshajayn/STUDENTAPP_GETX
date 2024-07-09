import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstydentdatabse/model/student.dart';
import 'package:getxstydentdatabse/services/functions.dart';
import 'package:getxstydentdatabse/utils/constants.dart';
import 'package:getxstydentdatabse/view/add_studentscreen.dart/add_student_screen.dart';
import 'package:getxstydentdatabse/view/widgets/app_bar_widget.dart';
import 'package:getxstydentdatabse/view/widgets/circle_avatar_widget.dart';
import 'package:getxstydentdatabse/view/widgets/text_form_widgetr.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.student});
  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameeditingController =
        TextEditingController(text: student.name);
    TextEditingController ageeditingController =
        TextEditingController(text: student.age.toString());
    TextEditingController departmenteditingController =
        TextEditingController(text: student.department);
    TextEditingController placeeditingController =
        TextEditingController(text: student.place);
    TextEditingController phoneNoeditingController =
        TextEditingController(text: student.phoneNumber.toString());
    TextEditingController guardianNameeditingController =
        TextEditingController(text: student.guardianName);
    final formKey = GlobalKey<FormState>();
    RxString pickedimage = RxString(student.imageUrl);

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
                      String? imagePath = await studentsController
                          .pickImage(ImageSource.gallery);
                      pickedimage.value = imagePath ?? '';
                    },
                    child: CircleAvatarWidget(
                        pickedimage: pickedimage, radius: 80),
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
                          controller: nameeditingController,
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
                          controller: ageeditingController,
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
                            controller: departmenteditingController,
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
                          controller: placeeditingController,
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
                          controller: phoneNoeditingController,
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
                          controller: guardianNameeditingController,
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
                              if (formKey.currentState!.validate() &&
                                  pickedimage.isNotEmpty) {
                                studentsController.updateStudent(StudentModel(
                                    id: student.id,
                                    name: nameeditingController.text,
                                    age: int.parse(ageeditingController.text),
                                    department:
                                        departmenteditingController.text,
                                    place: placeeditingController.text,
                                    phoneNumber: int.parse(
                                        phoneNoeditingController.text),
                                    guardianName:
                                        guardianNameeditingController.text,
                                    imageUrl: pickedimage.string));
                                print(
                                    'form is validated ${studentsController.students}');
                                snackBarFunction(
                                    title: 'Success',
                                    subtitle: 'Edited Successfully',
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
                                    dismissDirection:
                                        DismissDirection.horizontal,
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
        ));
  }
}
