import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/appbar/appbar_controller.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key, required this.drawerController}) : super(key: key);
  final CustomDrawerController drawerController;
  final localDataController = Get.find<LocalDataController>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double diameter = screenWidth * 1.58;
    const buttonHeight = 96.0;
    const buttonWidth = 172.0;
    final appBarController = Get.put(AppBarController());
    return Obx(
      () => appBarController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  top: -diameter / 2,
                  left: (screenWidth - diameter) / 2,
                  height: diameter,
                  width: diameter,
                  child: Container(
                    height: diameter,
                    width: diameter,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(28, 128, 195, 0.18),
                    ),
                  ),
                ),
                Positioned(
                  top: diameter / 2 -
                      buttonHeight / 2 -
                      buttonHeight /
                          10, // Điều chỉnh vị trí của container màu vàng
                  left: -(screenWidth - diameter) /
                      2, // Đặt left theo giá trị của hình tròn
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.chooseExamConditionScreen),
                    child: Container(
                      width: buttonWidth,
                      height: buttonHeight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: ColorPalette.primaryColor,
                          )),
                      child: const Center(
                          child: Text(
                        'Chọn đề thi',
                        style: TextStyle(
                            color: ColorPalette.primaryColor, fontSize: 16),
                      )),
                    ),
                  ),
                ),
                Positioned(
                    top: 50, // Điều chỉnh vị trí của container màu vàng
                    left: 0, // Đặt left theo giá trị của hình tròn
                    child: SizedBox(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => drawerController.openDrawer(),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.menu_outlined),
                                      )),
                                ),
                                InkWell(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.person_2_outlined),
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: kMinPadding / 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Xin chào,',
                                  style: TextStyle(
                                      height: 1,
                                      fontSize: 40,
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                AutoSizeText(
                                  localDataController.clientFullName(),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(290);
}
