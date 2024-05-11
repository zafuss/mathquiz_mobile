import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/exam_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/features/home/getx/home_controller.dart';
import 'package:mathquiz_mobile/widgets/custom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final customDrawerController = CustomDrawerController();
    final examController = Get.put(ExamController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        appBar: CustomAppBar(
          drawerController: customDrawerController,
        ),
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(
          () => !homeController.isLoading.value
              ? RefreshIndicator(
                  onRefresh: () async {
                    await examController.fetchExams();
                    await homeController.fetchRecentExam();
                    Future.delayed(Duration(seconds: 2));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () {
                            if (examController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (homeController.recentResults.length ==
                                0) {
                              return SizedBox();
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: kDefaultPadding,
                                        top: kMinPadding / 2,
                                        bottom: kMinPadding / 3),
                                    child: Text(
                                      'Đề bạn đã làm gần đây',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    height: 105,
                                    width: double.infinity,
                                    color: Colors.white.withOpacity(0.8),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        const SizedBox(
                                            width:
                                                kDefaultPadding), // SizedBox được thêm vào đầu danh sách
                                        ...homeController.recentResults.map(
                                          (element) => Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 15, right: 17),
                                            child: Container(
                                              width: 138,
                                              decoration: BoxDecoration(
                                                color: ColorPalette
                                                    .backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    examController.examList
                                                        .firstWhere((exam) =>
                                                            element.examId ==
                                                            exam.id)
                                                        .name!,
                                                    style: const TextStyle(
                                                        color: ColorPalette
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(children: [
                                                      const TextSpan(
                                                        text: "Số câu đúng: ",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${element.correctAnswers}/${element.totalQuiz}',
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ColorPalette
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ]),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(children: [
                                                      const TextSpan(
                                                        text: "Điểm: ",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '${element.score}',
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: ColorPalette
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: kDefaultPadding,
                              top: kMinPadding / 2,
                              bottom: kMinPadding / 3),
                          child: Text(
                            'Đề mới cập nhật',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 17,
                            childAspectRatio: 1.8,
                            children: List.generate(
                              7,
                              (index) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
