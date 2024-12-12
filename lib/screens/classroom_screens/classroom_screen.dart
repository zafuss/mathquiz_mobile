import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/chapter_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/quiz_matrix_controller.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/result_controller.dart';
import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';

import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../widgets/classroom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/news_widget.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({super.key});

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
                  title: classroomController.chosenClassroom.value!.name!,
                  membersAction: true,
                ),
                Expanded(
                  // Cuộn nội dung bên dưới
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await classroomController
                          .fetchClassroomDetailListByClassroomId();
                      await classroomController.fetchHomeworkList();
                      await classroomController.fetchNewsList();
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
                            child: Column(
                              children: [
                                classroomController.homeworkList.isEmpty
                                    ? const SizedBox()
                                    : classroomController.isTeacher.value
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: kMinPadding),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kDefaultPadding,
                                                        vertical:
                                                            kMinPadding / 2),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                            'Bài thi đã giao',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        InkWell(
                                                          child: const Text(
                                                            'Xem tất cả',
                                                            style: TextStyle(
                                                                color: ColorPalette
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          onTap: () {},
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: kMinPadding / 2,
                                                    ),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      itemCount:
                                                          classroomController
                                                                      .homeworkList
                                                                      .length >
                                                                  1
                                                              ? 2
                                                              : 1,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              bottom:
                                                                  kMinPadding),
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            onTap: () async {},
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: Colors
                                                                      .white),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        kMinPadding /
                                                                            2),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const SizedBox(
                                                                            width:
                                                                                kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              RichText(
                                                                                text: TextSpan(
                                                                                  style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: classroomController.homeworkList[index].title,
                                                                                      style: const TextStyle(fontWeight: FontWeight.bold), // In đậm
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.clip,
                                                                                softWrap: true,
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 4,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Có hiệu lực: ${classroomDateTimeFormatter(classroomController.homeworkList[index].handinDate)}',
                                                                                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                  Text(
                                                                                    'Hết hạn: ${classroomDateTimeFormatter(classroomController.homeworkList[index].expiredDate)}',
                                                                                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: kMinPadding),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kDefaultPadding,
                                                        vertical:
                                                            kMinPadding / 2),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                            'Bài thi được giao',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        InkWell(
                                                          child: const Text(
                                                            'Xem tất cả',
                                                            style: TextStyle(
                                                                color: ColorPalette
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          onTap: () {},
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: kMinPadding / 2,
                                                    ),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      itemCount:
                                                          classroomController
                                                                      .homeworkList
                                                                      .length >
                                                                  1
                                                              ? 2
                                                              : 1,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              bottom:
                                                                  kMinPadding),
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            onTap: () async {},
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color: Colors
                                                                      .white),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        kMinPadding /
                                                                            2),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const SizedBox(
                                                                            width:
                                                                                kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    RichText(
                                                                                      text: TextSpan(
                                                                                        style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: classroomController.homeworkList[index].title,
                                                                                            style: const TextStyle(fontWeight: FontWeight.bold), // In đậm
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.clip,
                                                                                      softWrap: true,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 4,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Có hiệu lực: ${classroomDateTimeFormatter(classroomController.homeworkList[index].handinDate)}',
                                                                                          style: const TextStyle(color: Colors.black54, fontSize: 13),
                                                                                        ),
                                                                                        Text(
                                                                                          'Hết hạn: ${classroomDateTimeFormatter(classroomController.homeworkList[index].expiredDate)}',
                                                                                          style: const TextStyle(color: Colors.black54, fontSize: 13),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: kMinPadding / 2),
                                                                                child: TextButton(
                                                                                    style: TextButton.styleFrom(backgroundColor: ColorPalette.backgroundColor),
                                                                                    onPressed: () async {
                                                                                      classroomController.chosenHomework.value = classroomController.homeworkList[index];
                                                                                      chapterController.chosenChapter.value = chapterController.chapterList.firstWhere((e) => e.id == classroomController.homeworkList[index].quizMatrix.chapterId);
                                                                                      quizMatrixController.chosenQuizMatrix.value = classroomController.homeworkList[index].quizMatrix;
                                                                                      await examController.fetchExams();
                                                                                      await examController.fetchExamByQuizMatrixId(quizMatrixController.chosenQuizMatrix.value!.id);
                                                                                      examController.tempNumOfQuiz.value = quizMatrixController.chosenQuizMatrix.value!.numOfQuiz!;
                                                                                      examController.tempDuration.value = quizMatrixController.chosenQuizMatrix.value!.defaultDuration!;
                                                                                      await examController.fetchRanking(chapterController.chosenChapter.value!.id);
                                                                                      Get.toNamed(Routes.classroomExamStartScreen);
                                                                                    },
                                                                                    child: Text(
                                                                                      'Làm ngay ${resultController.homeworkRemainingAttempt(classroomController.homeworkList[index])}',
                                                                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                                                                    )),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                classroomController.isTeacher.value
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: kMinPadding),
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    ColorPalette.primaryColor,
                                                foregroundColor: Colors.white),
                                            onPressed: () {
                                              classroomController
                                                  .resetDateTime();
                                              Get.toNamed(Routes
                                                  .classroomChooseExamScreen);
                                            },
                                            child:
                                                const Text('Giao bài tập mới')),
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      !classroomController.isTeacher.value
                                          ? const SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: kMinPadding / 2),
                                                  child: Text('Bảng tin',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: kMinPadding),
                                                  child: _createNewsWidget(
                                                      context,
                                                      classroomController),
                                                ),
                                              ],
                                            ),
                                      classroomController.newsList.isEmpty
                                          ? const Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: kMinPadding),
                                                child: Text(
                                                    'Lớp bạn chưa có bài viết nào'),
                                              ))
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                classroomController
                                                        .isTeacher.value
                                                    ? const SizedBox()
                                                    : const Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                kMinPadding / 2,
                                                            top: kMinPadding),
                                                        child: Text('Bảng tin',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: classroomController
                                                      .newsList.length,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          NewsWidget(
                                                    classroomController:
                                                        classroomController,
                                                    news: classroomController
                                                        .newsList[index],
                                                    callback: () =>
                                                        classroomController
                                                                .chosenNews
                                                                .value =
                                                            classroomController
                                                                    .newsList[
                                                                index],
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            )));
  }

  Column _createNewsWidget(
      BuildContext context, ClassroomController classroomController) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();
    LocalDataController localDataController = Get.find<LocalDataController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          onTap: () {
            showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Huỷ',
                              style: const TextStyle(
                                  color: ColorPalette.primaryColor),
                            )),
                        Obx(
                          () => classroomController.dialogLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await classroomController.createNews(
                                          _titleController.text,
                                          _contentController.text,
                                          context);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        ColorPalette.primaryColor, // Màu nền
                                    foregroundColor: Colors.white, // Màu chữ
                                  ),
                                  child: const Text('Đăng'),
                                ),
                        )
                      ],
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng ',
                            style: TextStyle(
                                color: ColorPalette.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'bài viết',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Tiêu đề',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextFormField(
                              controller: _titleController,
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tiêu đề không được để trống';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Nhập tiêu đề'),
                            ),
                            const SizedBox(
                              height: kMinPadding,
                            ),
                            const Text(
                              'Nội dung',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextFormField(
                              controller: _contentController,
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nội dung không được để trống';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Nhập nội dung cần đăng'),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorPalette.primaryColor),
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                color: Colors.white.withOpacity(0.6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMinPadding, vertical: kMinPadding / 1.5),
              child: Row(
                children: [
                  if (localDataController.clientImageUrl.value.isEmpty)
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.person_2_outlined),
                      ),
                    )
                  else
                    ClipOval(
                      child: Image.network(
                        localDataController.clientImageUrl.value,
                        fit: BoxFit.cover,
                        width: 45.0,
                        height: 45.0,
                      ),
                    ),
                  const SizedBox(
                    width: kMinPadding,
                  ),
                  const Expanded(
                    child: const Text(
                      'Thông báo gì đó cho lớp của bạn...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black38, fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
