import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstydentdatabse/services/functions.dart';
import 'package:getxstydentdatabse/utils/constants.dart';
import 'package:getxstydentdatabse/view/student_list_screen.dart/student_list_screen.dart';
import 'package:getxstydentdatabse/view/widgets/app_bar_widget.dart';
import 'package:getxstydentdatabse/view/widgets/text_form_widgetr.dart';
import 'package:getxstydentdatabse/viewmodel/student_controller.dart';

class SearchStudentScreen extends StatelessWidget {
  const SearchStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentControllerGetx =
        Get.put(StudentController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: AppBarWidget(title: 'Search Students'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            final filteredStudents = studentControllerGetx.filteredStudents;
            return Column(
              children: [
                TextFormFieldWidget(
                  onChanged: (p0) {
                    print('filtering query changed: $p0');
                    studentControllerGetx.filterStudents(p0);
                  },
                  controller: searchController,
                  hintText: 'Type the name of the student',
                  inputType: TextInputType.name,
                  prefixicon: Icons.search,
                ),
                Constants().kheight20,
                Expanded(
                  child: filteredStudents.isEmpty
                      ? const Center(
                          child: Text('No Student Found.'),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];
                            return InkWell(
                              onTap: () =>
                                  showStudentDetailsDialog(context, student),
                              child: StudentCardWidget(student: student),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Constants().kheight10,
                          itemCount: filteredStudents.length,
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
