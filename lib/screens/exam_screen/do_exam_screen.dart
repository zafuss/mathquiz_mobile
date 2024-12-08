import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/do_exam/getx/do_exam_controller.dart';
import 'package:mathquiz_mobile/helpers/latex_helpers.dart';
import '../../config/demension_const.dart';

class DoExamScreen extends StatelessWidget {
  DoExamScreen({super.key, this.func});
  final ScrollController _scrollController = ScrollController();
  final Function? func;

  void _scrollToSelectedItem(int index) {
    // Kích thước xấp xỉ của mỗi item (40 + 8 padding)
    double itemPosition = index * 44.0;
    double viewportStart = _scrollController.offset;
    double viewportEnd =
        viewportStart + _scrollController.position.viewportDimension;

    // Điều chỉnh vị trí đích cuộn
    double targetPosition;

    if (itemPosition < viewportStart) {
      // Trường hợp item nằm ngoài viewport ở phía trên
      targetPosition = itemPosition;
    } else if (itemPosition > viewportEnd - 44.0) {
      // Trường hợp item nằm ngoài viewport ở phía dưới
      targetPosition =
          itemPosition - (_scrollController.position.viewportDimension - 44.0);
    } else {
      // Item đã nằm trong viewport, không cần cuộn
      return;
    }

    // Cuộn tới vị trí đã xác định với animation
    _scrollController.animateTo(
      targetPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final doExamController = Get.put(DoExamController());
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                _showExitConfirmDialog(context, doExamController);
              },
            ),
          ),
          Obx(
            () => doExamController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kMinPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Expanded(child: SizedBox()),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(kMinPadding),
                                    color: Colors.white, // Màu của hình tròn
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                        child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/gradient_time_icon.png',
                                          height: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        ShaderMask(
                                          shaderCallback: (bounds) =>
                                              const LinearGradient(
                                            colors:
                                                ColorPalette.gradientColorList,
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [0.1, 1],
                                          ).createShader(Rect.fromLTWH(0, 0,
                                                  bounds.width, bounds.height)),
                                          child: AutoSizeText(
                                            _formatDuration(doExamController
                                                .remainingTime.value),
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: kMinPadding,
                            ),
                            _statementContainer(doExamController),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMinPadding / 4,
                                  horizontal: kMinPadding),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kMinPadding)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                height: 45,
                                                width: 45,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () {
                                                    if (doExamController
                                                        .isFirstQuiz.value) {
                                                      doExamController
                                                          .handlePreviousQuiz();
                                                      _scrollToSelectedItem(
                                                          doExamController
                                                              .currentQuizIndex
                                                              .value);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: doExamController
                                                              .isFirstQuiz.value
                                                          ? ColorPalette
                                                              .primaryColor
                                                          : ColorPalette
                                                              .greyColor,
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_back_ios_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kMinPadding / 2),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              onTap: () {
                                                doExamController
                                                    .handleMarkedQuiz();
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    width: 17,
                                                    doExamController.markedQuiz
                                                            .contains(
                                                                doExamController
                                                                    .currentQuizIndex
                                                                    .value)
                                                        ? 'assets/images/marker_icon.png'
                                                        : 'assets/images/unmarker_icon.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                switchInCurve: Curves.easeInOut,
                                                switchOutCurve:
                                                    Curves.easeInOut,
                                                layoutBuilder:
                                                    (Widget? currentChild,
                                                        List<Widget>
                                                            previousChildren) {
                                                  return Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: <Widget>[
                                                      if (currentChild != null)
                                                        currentChild,
                                                      ...previousChildren,
                                                    ],
                                                  );
                                                },
                                                transitionBuilder:
                                                    (Widget child,
                                                        Animation<double>
                                                            animation) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: SlideTransition(
                                                      position: Tween<Offset>(
                                                        begin: const Offset(1.0,
                                                            0.0), // Trượt vào từ bên phải
                                                        end: Offset.zero,
                                                      ).animate(animation),
                                                      child: ScaleTransition(
                                                        scale: Tween<double>(
                                                                begin: 0.8,
                                                                end: 1.0)
                                                            .animate(animation),
                                                        child: child,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: !doExamController
                                                        .isLastQuiz.value
                                                    ? InkWell(
                                                        key: const ValueKey(
                                                            'nextButton'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        onTap: () {
                                                          doExamController
                                                              .handleNextQuiz();
                                                          _scrollToSelectedItem(
                                                              doExamController
                                                                  .currentQuizIndex
                                                                  .value);
                                                        },
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: ColorPalette
                                                                .primaryColor,
                                                          ),
                                                          child: const Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        key: const ValueKey(
                                                            'submitButton'),
                                                        height: 45,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            if (await doExamController
                                                                .handleSubmitExam()) {
                                                              if (func !=
                                                                  null) {
                                                                func!();
                                                              } else {
                                                                Get.offNamed(Routes
                                                                    .resultScreen);
                                                              }
                                                            } else {
                                                              _submitFailedDialog(
                                                                  context,
                                                                  doExamController,
                                                                  func!);
                                                            }
                                                          },
                                                          child: doExamController
                                                                  .isGettingResult
                                                                  .value
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              : const Text(
                                                                  'Nộp bài'),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
          ),
        ],
      ),
    );
  }

  Flexible _statementContainer(DoExamController doExamController) {
    return Flexible(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(251, 252, 253, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(kMinPadding),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 38,
                        ),
                        const SizedBox(
                            height:
                                10.0), // khoảng cách giữa hình tròn và vạch dưới
                        Container(
                            height: 2.0,
                            width: double.infinity,
                            color: ColorPalette.greyColor),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          color: const Color.fromRGBO(251, 252, 253, 0.5),
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: doExamController.examDetailList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              bool isSelected = index ==
                                  doExamController.currentQuizIndex.value;

                              return GestureDetector(
                                onTap: () {
                                  doExamController.handleChangeQuiz(index);
                                  _scrollToSelectedItem(index);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                              milliseconds:
                                                  300), // Duration for the fade animation
                                          curve: Curves
                                              .easeInOut, // Smooth animation curve
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? const LinearGradient(
                                                    colors: ColorPalette
                                                        .gradientColorList,
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    stops: [0.2, 1.0],
                                                  )
                                                : const LinearGradient(
                                                    colors: [
                                                      ColorPalette.greyColor,
                                                      ColorPalette.greyColor
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              8.0), // spacing between the circle and the underline
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        height: 2.0,
                                        width: 40,
                                        color: doExamController.markedQuiz
                                                .contains(index)
                                            ? Colors.amber
                                            : isSelected ||
                                                    doExamController
                                                        .isChosen(index)
                                                ? Colors.blue
                                                : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        renderTextAndLaTeX(
                            doExamController.currentQuiz.value!.statement!,
                            null),
                        doExamController.currentQuiz.value!.image != null
                            ? Padding(
                                padding: const EdgeInsets.all(kMinPadding / 2),
                                child: renderImage(doExamController),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: kMinPadding,
          ),
          Column(
            children: doExamController.currentQuizOptions
                .asMap()
                .map((index, e) => MapEntry(
                      index,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: kMinPadding * 0.8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(kMinPadding),
                          splashColor:
                              ColorPalette.primaryColor.withOpacity(0.1),
                          onTap: () =>
                              doExamController.handleChooseAnOption(e.id),
                          hoverColor:
                              ColorPalette.primaryColor.withOpacity(0.1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: e.id ==
                                              doExamController.currentExamDetail
                                                  .value!.selectedOption
                                          ? ColorPalette.primaryColor
                                          : ColorPalette.greyColor),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      e.quizOptionImage != null
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            kMinPadding / 2),
                                                child: SvgPicture.network(
                                                  width: 125,
                                                  e.quizOptionImage!,
                                                  placeholderBuilder: (BuildContext
                                                          context) =>
                                                      const CircularProgressIndicator(),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      e.id ==
                                              doExamController.currentExamDetail
                                                  .value!.selectedOption
                                          ? renderTextAndLaTeX(e.option!,
                                              ColorPalette.primaryColor)
                                          : renderTextAndLaTeX(e.option!, null),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                .values
                .toList(),
          ),
          const SizedBox(
            height: kMinPadding / 2,
          ),
        ],
      ),
    );
  }

  void _showExitConfirmDialog(
      BuildContext context, DoExamController doExamController) {
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
                'Thoát khỏi ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'bài thi',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content:
              const Text('Bạn có chắc chắn muốn thoát khỏi bài thi không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                doExamController.stopTimer();
                Get.back(); // Close the dialog
                Navigator.of(context).pop(); // Close the screen
              },
              child: const Text(
                'Có',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitFailedDialog(
      BuildContext context, DoExamController doExamController, Function func) {
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
                'Vẫn nộp ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'bài thi',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: const Text(
              'Có một số câu chưa chọn đáp án, bạn vẫn muốn nộp bài chứ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () async {
                await doExamController.forceSubmitExam();
                if (func != null) {
                  func();
                } else {
                  Get.offAndToNamed(Routes.resultScreen);
                }
              },
              child: const Text(
                'Có',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget renderImage(DoExamController doExamController) {
    try {
      return SvgPicture.network(
        doExamController.currentQuiz.value!.image!,
        placeholderBuilder: (BuildContext context) =>
            const CircularProgressIndicator(),
      );
    } catch (e) {
      var image = Image.network(
        doExamController.currentQuiz.value!.image!,
        fit: BoxFit.fill,
      );

      return image;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigitHours == "00") {
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }
  }
}
