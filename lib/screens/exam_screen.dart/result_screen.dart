import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/do_exam_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doExamController = Get.find<DoExamController>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          doExamController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText(
                              'Chúc mừng bạn đã hoàn thành bài thi!',
                              style: TextStyle(
                                  height: 1,
                                  fontSize: 30,
                                  color: ColorPalette.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            Text.rich(
                              TextSpan(children: [
                                const TextSpan(
                                  text: "Điểm: ",
                                ),
                                TextSpan(
                                  text: doExamController.result.value!.score
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                const TextSpan(
                                  text: "Số câu đúng: ",
                                ),
                                TextSpan(
                                  text:
                                      '${doExamController.result.value!.correctAnswers}/${doExamController.result.value!.totalQuiz}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => Get.offAllNamed(Routes.homeScreen),
                          child: const Text('Trở về màn hình chính'))
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
