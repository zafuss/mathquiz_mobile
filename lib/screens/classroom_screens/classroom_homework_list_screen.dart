import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/result_controller.dart';
import 'package:mathquiz_mobile/widgets/homework_list_widget.dart';

import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../widgets/classroom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class ClassroomHomeworkListScreen extends StatelessWidget {
  const ClassroomHomeworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = CustomDrawerController();
    final classroomController = Get.put(ClassroomController());
    final quizMatrixController = Get.put(QuizMatrixController());
    final chapterController = Get.put(ChapterController());
    final examController = Get.put(ExamController());
    final resultController = Get.put(ResultController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(() => Column(
              children: [
                // AppBar luôn cố định ở trên cùng
                ClassroomAppBarContainer(
                  backAction: true,
                  drawerController: customDrawerController,
                  title: Text(
                    classroomController.chosenClassroom.value!.name!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                  membersAction: true,
                ),
                Expanded(
                  // Cuộn nội dung bên dưới
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await classroomController.fetchHomeworkList();
                    },
                    child: classroomController.isLoading.value ||
                            quizMatrixController.isLoading.value ||
                            chapterController.isLoading.value ||
                            examController.isLoading.value ||
                            resultController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: HomeworkListWidget(
                              classroomController: classroomController,
                              resultController: resultController,
                              chapterController: chapterController,
                              quizMatrixController: quizMatrixController,
                              examController: examController,
                              itemCount:
                                  classroomController.homeworkList.length,
                            ),
                          ),
                  ),
                ),
              ],
            )));
  }
}
