import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/homework/classroom_homework_results_dto.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/helpers/score_formatter.dart';

import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

class ClassroomHomeworkBestResultScreen extends StatelessWidget {
  const ClassroomHomeworkBestResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = CustomDrawerController();

    final classroomController = Get.put(ClassroomController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(() {
          int numOfStudent = classroomController.bestResultList
              .where((e) => e.attemptCount! > 0)
              .toList()
              .length;
          return Column(
            children: [
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
              ),
              !classroomController.isLoading.value
                  ? Flexible(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await classroomController
                              .fetchClassroomDetailListByClassroomId();
                        },
                        child: SingleChildScrollView(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ClassroomHomeworkBestResultsListView(
                                  title:
                                      'Số học sinh đã làm ${numOfStudent}/${classroomController.bestResultList.length}',
                                  numOfItems:
                                      classroomController.bestResultList.length,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          );
        }));
  }
}

// ignore: must_be_immutable
class ClassroomHomeworkBestResultsListView extends StatelessWidget {
  ClassroomHomeworkBestResultsListView(
      {super.key,
      required this.title,
      required this.numOfItems,
      this.seeAllFunc});

  final String title;
  ClassroomController classroomController = Get.find<ClassroomController>();
  final int numOfItems;

  final Function? seeAllFunc;

  @override
  Widget build(BuildContext context) {
    LocalDataController localDataController = Get.find<LocalDataController>();
    return Obx(
      () => classroomController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.6)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kMinPadding / 2),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        seeAllFunc != null
                            ? InkWell(
                                child: const Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () => seeAllFunc!(),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: kMinPadding / 2,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: numOfItems,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: kMinPadding),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            onTap: () {
                              if (classroomController
                                      .bestResultList[index].attemptCount! >
                                  0) {
                                List<ClassroomHomeworkResultsDto>
                                    currentStudentResults = classroomController
                                        .resultList
                                        .where((e) =>
                                            e.student ==
                                            classroomController
                                                .bestResultList[index].student)
                                        .toList();
                                currentStudentResults.sort((a, b) => a
                                    .result!.endTime!
                                    .compareTo(b.result!.endTime!));
                                if (currentStudentResults.isEmpty) {
                                  return; // Không hiển thị nếu danh sách rỗng
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Kết quả ',
                                          style: TextStyle(
                                              color: ColorPalette.primaryColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'bài tập',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: currentStudentResults
                                            .asMap()
                                            .entries
                                            .map(
                                              (entry) => Text(
                                                'Điểm lần ${entry.key + 1}: ${scoreFormatter(entry.value.result!.score!)}',
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    actions: [
                                      SizedBox(
                                        child: ElevatedButton(
                                            onPressed: () => Get.back(),
                                            child: Text('Đóng')),
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kMinPadding / 2),
                                child: Column(
                                  children: [
                                    const SizedBox(width: kMinPadding),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kMinPadding),
                                      child: Row(
                                        children: [
                                          classroomController
                                                      .bestResultList[index]
                                                      .student
                                                      .imageUrl ==
                                                  null
                                              ? Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(Icons
                                                        .person_2_outlined),
                                                  ),
                                                )
                                              : ClipOval(
                                                  child: Image.network(
                                                    classroomController
                                                        .bestResultList[index]
                                                        .student
                                                        .imageUrl!,
                                                    fit: BoxFit.cover,
                                                    width: 45.0,
                                                    height: 45.0,
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: kMinPadding / 2,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style
                                                              .copyWith(
                                                                  color: ColorPalette
                                                                      .primaryColor),
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  '${classroomController.bestResultList[index].student.fullname}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold), // In đậm
                                                            ),
                                                            TextSpan(
                                                              text: localDataController
                                                                          .clientId
                                                                          .value ==
                                                                      classroomController
                                                                          .bestResultList[
                                                                              index]
                                                                          .student
                                                                          .id
                                                                  ? ' (bạn)'
                                                                  : '',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300), // In đậm
                                                            )
                                                          ],
                                                        ),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                classroomController
                                                            .bestResultList[
                                                                index]
                                                            .result !=
                                                        null
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          classroomController
                                                                      .bestResultList[
                                                                          index]
                                                                      .attemptCount ==
                                                                  0
                                                              ? SizedBox()
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                      'Số câu đúng: ${classroomController.bestResultList[index].result!.correctAnswers}/${classroomController.bestResultList[index].result!.totalQuiz}',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize:
                                                                              13),
                                                                    )
                                                                  ],
                                                                ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                classroomController
                                                            .bestResultList[
                                                                index]
                                                            .result !=
                                                        null
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Số lần làm: ${classroomController.bestResultList[index].attemptCount}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        13),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                          if (classroomController
                                                  .bestResultList[index]
                                                  .attemptCount! >
                                              0)
                                            Column(
                                              children: [
                                                Text(
                                                  '${scoreFormatter(classroomController.bestResultList[index].result!.score!)}',
                                                  style: const TextStyle(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'điểm',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                ),
                                              ],
                                            )
                                          else
                                            const SizedBox(),
                                        ],
                                      ),
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
    );
  }
}
