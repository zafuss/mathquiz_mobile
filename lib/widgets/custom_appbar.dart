import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/appbar/appbar_controller.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';

class CustomAppBarContainer extends StatelessWidget {
  CustomAppBarContainer({super.key, required this.drawerController});
  final CustomDrawerController drawerController;
  final localDataController = Get.put(LocalDataController());
  final gradeController = Get.put(GradeController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final appBarController = Get.put(AppBarController());
    return Obx(() => appBarController.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                  height: kDefaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                    InkWell(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      child: localDataController.clientImageUrl.value.isEmpty
                          ? Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person_2_outlined),
                              ),
                            )
                          : ClipOval(
                              child: Image.network(
                                localDataController.clientImageUrl.value,
                                fit: BoxFit.cover,
                                width: 45.0,
                                height: 45.0,
                              ),
                            ),
                      onTap: () =>
                          Get.toNamed(Routes.personalInformationScreen),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kMinPadding / 2,
                ),
                const Text(
                  'Xin chào,',
                  style: TextStyle(
                    height: 1,
                    fontSize: 32,
                    color: ColorPalette.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AutoSizeText(
                  localDataController.clientFullName(),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Button background color
                        side: const BorderSide(
                            color: ColorPalette.primaryColor,
                            width: 2), // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                        ),
                      ),
                      onPressed: () =>
                          Get.toNamed(Routes.chooseExamConditionScreen),
                      child: const Text(
                        'Thi ngay',
                        style: TextStyle(
                            fontSize: 16, color: ColorPalette.primaryColor),
                      ),
                    )),
                const SizedBox(
                  height: kMinPadding,
                )
              ],
            ),
          ));
  }
}
