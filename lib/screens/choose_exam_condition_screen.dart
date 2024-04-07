import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/level_controller.dart';
import 'package:mathquiz_mobile/models/chapter.dart';
import 'package:mathquiz_mobile/models/grade.dart';
import 'package:mathquiz_mobile/models/level.dart';

import '../config/demension_const.dart';
import '../features/choose_exam/getx/grade_controller.dart';

class ChooseExamConditionScreen extends StatelessWidget {
  const ChooseExamConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levelController = Get.put(LevelController());
    final gradeController = Get.put(GradeController());
    final chapterController = Get.put(ChapterController());
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Chọn ",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "đề thi",
                      style: TextStyle(
                          fontSize: 40,
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: kDefaultPadding * 2,
                ),
                const Text('Cấp học'),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => levelController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Level>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints:
                                const BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor: const Color.fromRGBO(251, 252, 253, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: levelController
                              .chosenLevel.value, // Default value
                          onChanged: (Level? newValue) {
                            // Handle dropdown value changes
                            print(newValue);
                            levelController.handleOnChangedLevel(
                                newValue, gradeController, chapterController);
                            // gradeController.fetchGradesByLevelId(newValue!.id);
                          },
                          items: levelController.levelList
                              .map<DropdownMenuItem<Level>>((Level value) {
                            return DropdownMenuItem<Level>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const SizedBox(
                  height: kMinPadding,
                ),
                const Text('Lớp'),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => gradeController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Grade>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints:
                                const BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor:
                                ColorPalette.primaryColor.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: gradeController
                              .chosenGrade.value, // Default value
                          onChanged: (Grade? newValue) {
                            gradeController.handleOnChangedGrade(
                                newValue, chapterController);
                            // Handle dropdown value changes
                            print(newValue);
                          },
                          items: gradeController.searchedGradeList
                              .map<DropdownMenuItem<Grade>>((Grade value) {
                            return DropdownMenuItem<Grade>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const SizedBox(
                  height: kMinPadding,
                ),
                const Text('Chương'),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => chapterController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Chapter>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints:
                                const BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor: const Color.fromRGBO(251, 252, 253, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: chapterController
                              .chosenChapter.value, // Default value
                          onChanged: (Chapter? newValue) {
                            // Handle dropdown value changes
                            print(newValue);
                          },
                          items: chapterController.searchedChapterList
                              .map<DropdownMenuItem<Chapter>>((Chapter value) {
                            return DropdownMenuItem<Chapter>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const SizedBox(
                  height: kMinPadding + 10,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Tiếp tục'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
