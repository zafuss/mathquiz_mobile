import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/level_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';
import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';

import '../../config/demension_const.dart';
import '../../features/choose_exam/getx/grade_controller.dart';

class ClassroomEditHomeworkScreen extends StatelessWidget {
  const ClassroomEditHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _formKey = GlobalKey<FormState>();
    final classroomController = Get.find<ClassroomController>();
    final levelController = Get.put(LevelController());
    final gradeController = Get.put(GradeController());

    final _titleController = TextEditingController();
    final _contentController = TextEditingController();
    final customDrawerController = CustomDrawerController();
    _titleController.text = classroomController.chosenHomework.value!.title;
    _contentController.text = classroomController.chosenHomework.value!.content;
    classroomController.assignDateTime.value =
        classroomController.chosenHomework.value!.handinDate;
    classroomController.deadlineDateTime.value =
        classroomController.chosenHomework.value!.expiredDate;
    classroomController.homeworkAttempt.value =
        classroomController.chosenHomework.value!.attempt;
    return Scaffold(
      body: Obx(
        () {
          if (levelController.isLoading.value ||
              gradeController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                ClassroomAppBarContainer(
                  backAction: true,
                  drawerController: customDrawerController,
                  title: const Text(
                    'Sửa bài tập',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: kMinPadding / 2),
                          //   child: Text(
                          //     'Chọn đề thi cho lớp ${classroomController.chosenClassroom.value!.name}',
                          //     style: TextStyle(fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(251, 252, 253, 1),
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kMinPadding,
                                  vertical: kMinPadding),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Tiêu đề',
                                      style: const TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextFormField(
                                      controller: _titleController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Tiêu dề không thể để trống';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultBorderRadius))),
                                    ),
                                    const SizedBox(
                                      height: kMinPadding / 2,
                                    ),
                                    const Text(
                                      'Nội dung',
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextFormField(
                                      maxLines: 3,
                                      controller: _contentController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nội dung không thể để trống';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultBorderRadius))),
                                    ),
                                    const SizedBox(
                                      height: kMinPadding / 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ngày giao',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextFormField(
                                          readOnly:
                                              true, // Không cho phép nhập tay
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        defaultBorderRadius)),
                                            suffixIcon: const Icon(
                                                Icons.calendar_today),
                                          ),
                                          controller: TextEditingController(
                                              text: classroomDateTimeFormatter(
                                                  classroomController
                                                      .assignDateTime.value
                                                      .toLocal())),
                                          onTap: () async {
                                            // Hiển thị DatePicker trước
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            );

                                            if (pickedDate != null) {
                                              // Kiểm tra nếu `pickedDate` lớn hơn `deadlineDateTime`
                                              if (pickedDate.isAfter(
                                                  classroomController
                                                      .deadlineDateTime
                                                      .value)) {
                                                classroomController
                                                    .deadlineDateTime
                                                    .value = DateTime(
                                                  pickedDate.year,
                                                  pickedDate.month,
                                                  pickedDate.day,
                                                  23,
                                                  59,
                                                );
                                              }
                                              // Luôn hiển thị TimePicker
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );

                                              if (pickedTime != null) {
                                                classroomController
                                                    .assignDateTime
                                                    .value = DateTime(
                                                  pickedDate.year,
                                                  pickedDate.month,
                                                  pickedDate.day,
                                                  pickedTime.hour,
                                                  pickedTime.minute,
                                                );
                                              }
                                            }
                                          },
                                          validator: (value) {
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kMinPadding / 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Hạn làm bài',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextFormField(
                                          readOnly:
                                              true, // Không cho phép nhập tay
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        defaultBorderRadius)),
                                            suffixIcon: const Icon(
                                                Icons.calendar_today),
                                          ),
                                          controller: TextEditingController(
                                              text: classroomDateTimeFormatter(
                                                  classroomController
                                                      .deadlineDateTime.value
                                                      .toLocal())),
                                          onTap: () async {
                                            DateTime currentAssignDateTime =
                                                classroomController
                                                    .assignDateTime.value;
                                            DateTime initialDate = DateTime(
                                                currentAssignDateTime.year,
                                                currentAssignDateTime.month,
                                                currentAssignDateTime.day,
                                                23,
                                                59);
                                            // Hiển thị DatePicker trước
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: initialDate,
                                              firstDate: initialDate,
                                              lastDate: DateTime(2100),
                                            );

                                            if (pickedDate != null) {
                                              if (pickedDate.isBefore(
                                                  classroomController
                                                      .assignDateTime.value)) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const AlertDialog(
                                                          content: Text(
                                                              'Ngày giao phải trước hạn làm bài'),
                                                        ));
                                              } else {
                                                // Hiển thị TimePicker sau
                                                TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );

                                                if (pickedTime != null) {
                                                  // Kết hợp Date và Time
                                                  classroomController
                                                      .deadlineDateTime
                                                      .value = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    pickedTime.hour,
                                                    pickedTime.minute,
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          validator: (value) {
                                            if (classroomController
                                                    .assignDateTime.value
                                                    .compareTo(
                                                        classroomController
                                                            .deadlineDateTime
                                                            .value) ==
                                                0) {
                                              return 'aa';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kMinPadding / 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Số lần làm',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  classroomController
                                                          .homeworkAttempt
                                                          .value =
                                                      _handleOnModifyAttempt(
                                                          classroomController
                                                              .homeworkAttempt
                                                              .value,
                                                          -1);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorPalette
                                                              .primaryColor),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: kDefaultPadding * 2,
                                                child: Center(
                                                  child: Text(
                                                      classroomController
                                                          .homeworkAttempt.value
                                                          .toString()),
                                                ),
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  classroomController
                                                          .homeworkAttempt
                                                          .value =
                                                      _handleOnModifyAttempt(
                                                          classroomController
                                                              .homeworkAttempt
                                                              .value,
                                                          1);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorPalette
                                                              .primaryColor),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kMinPadding / 2,
                                    ),
                                    const Text(
                                      'Đề thi',
                                      style: TextStyle(
                                          color: ColorPalette.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    InkWell(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: classroomController
                                                    .chosenHomework.value !=
                                                null
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        '${classroomController.chosenHomework.value!.quizMatrix!.name!}'),
                                                  )
                                                ],
                                              )
                                            : const Text(
                                                'Bấm vào đây để chọn đề thi',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: kMinPadding,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  await classroomController
                                                      .editHomework(
                                                    _titleController.text,
                                                    _contentController.text,
                                                    context,
                                                  );
                                                }
                                              },
                                              child: classroomController
                                                      .isLoading.value
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Text('Sửa bài tập')),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              classroomController
                                                                          .chosenHomework
                                                                          .value!
                                                                          .status ==
                                                                      1
                                                                  ? 'Xoá '
                                                                  : 'Giao lại ',
                                                              style: const TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const Text(
                                                              'bài tập',
                                                              style: TextStyle(
                                                                  color: ColorPalette
                                                                      .primaryColor,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const Text(
                                                              '?',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        content: Text(classroomController
                                                                    .chosenHomework
                                                                    .value!
                                                                    .status ==
                                                                1
                                                            ? 'Xoá '
                                                            : 'Giao lại '
                                                                '${classroomController.chosenHomework.value!.title}?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Hủy'),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await classroomController
                                                                  .changeHomeworkStatus(
                                                                      context,
                                                                      classroomController.chosenHomework.value!.status ==
                                                                              1
                                                                          ? 0
                                                                          : 1);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              classroomController
                                                                          .chosenHomework
                                                                          .value!
                                                                          .status ==
                                                                      1
                                                                  ? 'Xoá'
                                                                  : 'Đồng ý',
                                                              style: TextStyle(
                                                                  color: classroomController
                                                                              .chosenHomework
                                                                              .value!
                                                                              .status ==
                                                                          0
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                            },
                                            icon: classroomController
                                                        .chosenHomework
                                                        .value!
                                                        .status ==
                                                    1
                                                ? const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )
                                                : const Icon(
                                                    Icons.assignment_add,
                                                    color: Colors.green,
                                                  ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  _handleOnModifyAttempt(int currentAttempt, int num) {
    if (currentAttempt + num == 0) {
      return currentAttempt;
    }
    return currentAttempt + num;
  }

  Column _chooseExamWidget(
      BuildContext context,
      LevelController levelController,
      GradeController gradeController,
      ChapterController chapterController,
      QuizMatrixController quizmatrixController,
      ClassroomController classroomController,
      ExamController examController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _showLevelDialog(
                context, levelController, gradeController, chapterController);
          },
          child: Container(
            // height:
            //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
            //         kDefaultPadding / 2,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(251, 252, 253, 1),
            ),
            child: Center(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMinPadding / 2),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/level_icon.png',
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: kMinPadding / 3,
                  ),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cấp học',
                            style: TextStyle(
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            levelController.chosenLevel.value?.name ??
                                'Chọn cấp',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kMinPadding / 2, horizontal: kMinPadding / 3),
          child: Container(
            height: 1,
            width: double.infinity,
            color: ColorPalette.greyColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showGradeDialog(
                context, gradeController, chapterController, levelController);
          },
          child: Container(
            // height:
            //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
            //         kDefaultPadding / 2,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(251, 252, 253, 1),
            ),
            child: Center(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMinPadding / 2),
                    child: Image.asset(
                      'assets/images/grade_icon.png',
                      height: 45,
                    ),
                  ),
                  const SizedBox(
                    width: kMinPadding / 3,
                  ),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          levelController.chosenLevel.value!.id == 4
                              ? const Text(
                                  'Môn',
                                  style: TextStyle(
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                )
                              : const Text(
                                  'Lớp',
                                  style: TextStyle(
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                          Text(
                            textAlign: TextAlign.center,
                            gradeController.chosenGrade.value?.name ??
                                'Chọn lớp',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => chapterController.isHasMultiMathType.value
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMinPadding / 3, vertical: kMinPadding / 3),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: ColorPalette.primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                chapterController.fetchChapterByMathType(
                                    1, gradeController.chosenGrade.value!.id),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft:
                                        Radius.circular(defaultBorderRadius),
                                    bottomLeft:
                                        Radius.circular(defaultBorderRadius)),
                                color:
                                    chapterController.chosenMathType.value == 1
                                        ? ColorPalette.primaryColor
                                        : Colors.white,
                              ),
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Đại số',
                                style:
                                    chapterController.chosenMathType.value == 1
                                        ? const TextStyle(color: Colors.white)
                                        : null,
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                chapterController.fetchChapterByMathType(
                                    2, gradeController.chosenGrade.value!.id),
                            child: Container(
                              color: chapterController.chosenMathType.value == 2
                                  ? ColorPalette.primaryColor
                                  : Colors.white,
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Hình học',
                                style:
                                    chapterController.chosenMathType.value == 2
                                        ? const TextStyle(color: Colors.white)
                                        : null,
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                chapterController.fetchChapterByMathType(
                                    7, gradeController.chosenGrade.value!.id),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight:
                                        Radius.circular(defaultBorderRadius),
                                    bottomRight:
                                        Radius.circular(defaultBorderRadius)),
                                color:
                                    chapterController.chosenMathType.value == 7
                                        ? ColorPalette.primaryColor
                                        : Colors.white,
                              ),
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Tổng hợp',
                                style:
                                    chapterController.chosenMathType.value == 7
                                        ? const TextStyle(color: Colors.white)
                                        : null,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kMinPadding / 2, horizontal: kMinPadding / 3),
          child: Container(
            height: 1,
            width: double.infinity,
            color: ColorPalette.greyColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            _showChapterDialog(
                context, chapterController, quizmatrixController);
          },
          child: Container(
            // height:
            //     (SizeConfig.screenWidth! - kDefaultPadding * 2) / 2 -
            //         kDefaultPadding / 2,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(251, 252, 253, 1),
            ),
            child: Center(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMinPadding / 2),
                    child: Image.asset(
                      'assets/images/chapter_icon.png',
                      height: 45,
                    ),
                  ),
                  const SizedBox(
                    width: kMinPadding / 3,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chương',
                          style: TextStyle(
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Obx(
                          () => chapterController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : chapterController.chosenChapter.value?.name ==
                                      null
                                  ? const Text(
                                      'Chọn chương',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text.rich(
                                      TextSpan(children: [
                                        TextSpan(
                                            text: chapterController
                                                .chosenChapter.value?.name),
                                        TextSpan(
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400),
                                            text: quizmatrixController
                                                        .quizMatrixList
                                                        .firstWhereOrNull(
                                                            (element) =>
                                                                element
                                                                    .chapterId ==
                                                                chapterController
                                                                    .chosenChapter
                                                                    .value!
                                                                    .id) !=
                                                    null
                                                ? ': ${quizmatrixController.quizMatrixList.firstWhereOrNull((element) => element.chapterId == chapterController.chosenChapter.value!.id)!.name}'
                                                : ""),
                                      ]),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Obx(
          () => ElevatedButton(
            style: ButtonStyle(
              backgroundColor: chapterController.chosenChapter.value != null
                  ? WidgetStateProperty.all<Color>(ColorPalette.primaryColor)
                  : WidgetStateProperty.all<Color>(
                      const Color.fromARGB(255, 209, 208, 208)
                          .withOpacity(0.5)),
            ),
            onPressed: () async {
              if (chapterController.chosenChapter.value == null) {
              } else {
                // await quizmatrixController.fetchQuizMatricesByChapterId(
                //     chapterController.chosenChapter.value!.id);
                // await examController.fetchExams();
                // await examController.fetchExamByQuizMatrixId(
                //     quizmatrixController.chosenQuizMatrix.value!.id);
                // examController.tempNumOfQuiz.value =
                //     quizmatrixController.chosenQuizMatrix.value!.numOfQuiz!;
                // examController.tempDuration.value = quizmatrixController
                //     .chosenQuizMatrix.value!.defaultDuration!;
                // await examController
                //     .fetchRanking(chapterController.chosenChapter.value!.id);
                // Get.toNamed(Routes.examStartScreen);

                classroomController.chosenAssignChapter.value =
                    chapterController.chosenChapter.value;
                classroomController.chosenAssignQuizMatrix.value =
                    quizmatrixController.quizMatrixList.firstWhereOrNull(
                        (element) =>
                            element.chapterId ==
                            chapterController.chosenChapter.value!.id);
                Navigator.of(context).pop();
              }
            },
            child: quizmatrixController.isLoading.value ||
                    examController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('Tiếp tục'),
          ),
        ),
      ],
    );
  }

  void _showLevelDialog(BuildContext context, LevelController levelController,
      GradeController gradeController, ChapterController chapterController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'cấp học',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: levelController.levelList
                  .map((level) => ListTile(
                      title: Text(level.name),
                      onTap: () {
                        levelController.handleOnChangedLevel(
                            level, gradeController, chapterController);
                        Get.back();
                      }))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showGradeDialog(BuildContext context, GradeController gradeController,
      ChapterController chapterController, LevelController levelController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Obx(
                () => levelController.chosenLevel.value!.id == 4
                    ? const Text(
                        'môn',
                        style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      )
                    : const Text(
                        'lớp',
                        style: TextStyle(
                            color: ColorPalette.primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: gradeController.searchedGradeList
                  .map((grade) => ListTile(
                      title: Text(grade.name),
                      onTap: () {
                        gradeController.handleOnChangedGrade(
                            grade, chapterController);
                        Get.back();
                      }))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _showChapterDialog(
      BuildContext context,
      ChapterController chapterController,
      QuizMatrixController quizMatrixController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'chương',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: chapterController.searchedChapterList.map((chapter) {
                var quizMatrixName = quizMatrixController.quizMatrixList
                            .firstWhereOrNull(
                                (element) => element.chapterId == chapter.id) !=
                        null
                    ? quizMatrixController.quizMatrixList
                        .firstWhereOrNull(
                            (element) => element.chapterId == chapter.id)!
                        .name!
                    : '';
                return ListTile(
                    title: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: '${chapter.name}: ',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: quizMatrixName,
                      ),
                    ])),
                    onTap: () => {
                          chapterController.chosenChapter.value = chapter,
                          Get.back()
                        });
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
