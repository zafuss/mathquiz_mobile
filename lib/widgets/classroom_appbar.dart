import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/appbar/appbar_controller.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';

class ClassroomAppBarContainer extends StatelessWidget {
  ClassroomAppBarContainer(
      {super.key,
      required this.drawerController,
      required this.title,
      this.backAction = false,
      this.membersAction = false});
  final CustomDrawerController drawerController;
  final Widget title;
  final bool backAction;
  final bool membersAction;
  final localDataController = Get.put(LocalDataController());
  final gradeController = Get.put(GradeController());
  final classroomController = Get.find<ClassroomController>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final appBarController = Get.put(AppBarController());
    return Obx(() => appBarController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(defaultBorderRadius),
                    bottomRight: Radius.circular(defaultBorderRadius)),
                gradient: LinearGradient(
                    colors: ColorPalette.appBarGradientColorList,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            width: screenWidth,
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: kDefaultPadding * 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backAction
                        ? InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back_ios_outlined),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () => drawerController.openDrawer(),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.menu_outlined),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: kMinPadding / 2,
                    ),
                    Expanded(child: title),
                    membersAction
                        ? InkWell(
                            onTap: () async {
                              await classroomController
                                  .fetchClassroomDetailListByClassroomId();
                              Get.toNamed(Routes.classroomMembersScreen);
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.group_outlined)),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: kMinPadding,
                )
              ],
            ),
          ));
  }
}
