import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';

import '../config/media_query_config.dart';

class CustomDrawer extends StatelessWidget {
  final CustomDrawerController? controller;
  const CustomDrawer({
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final LocalDataController localDataController =
        Get.find<LocalDataController>();
    // final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: 0.85 * SizeConfig.screenWidth!,
      child: Obx(() => localDataController.isLoading.isFalse
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 170,
                  color: ColorPalette.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding, top: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: ColorPalette.backgroundColor,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: ColorPalette.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          localDataController.clientFullName.value
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                        horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () {},
                          title: const Text('Lịch sử làm bài'),
                        ),
                        const Spacer(), // Add Spacer to push the button to the bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await localDataController
                                        .deleteClientEmail();
                                    await localDataController
                                        .deleteClientFullName();
                                    await localDataController.deleteClientId();
                                    Get.offAndToNamed(Routes.loginScreen);
                                  },
                                  child: const Text('Đăng xuất')),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Hỗ trợ',
                                  style: TextStyle(
                                      color: ColorPalette.primaryColor),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            )),
    );
  }
}
