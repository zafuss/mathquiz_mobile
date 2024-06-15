import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
        Get.put(LocalDataController());
    final AuthController authController = Get.put(AuthController());
    return Drawer(
      width: 0.85 * SizeConfig.screenWidth!,
      child: Obx(() => localDataController.isLoading.isFalse
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
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
                            GestureDetector(
                              onTap: () async {
                                await authController.pickImage();
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            ColorPalette.backgroundColor,
                                        child: !authController
                                                .isUploadingAvatar.value
                                            ? localDataController.clientImageUrl
                                                    .value.isEmpty
                                                ? const Icon(
                                                    Icons.person_2_outlined,
                                                    color: ColorPalette
                                                        .primaryColor,
                                                  )
                                                : ClipOval(
                                                    child: Image.network(
                                                      localDataController
                                                          .clientImageUrl.value,
                                                      fit: BoxFit.cover,
                                                      width: 60.0,
                                                      height: 60.0,
                                                    ),
                                                  )
                                            : const Center(
                                                child: SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                      )),
                                  Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorPalette.backgroundColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.edit_outlined,
                                            size: 15,
                                          ),
                                        ),
                                      ))
                                ],
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
                  ],
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
                          onTap: () {
                            authController.isChangingInformation.value = false;
                            controller!.closeDrawer();
                            // _showPersonalInformationDialog(context);
                            Get.toNamed(Routes.personalInformationScreen);
                          },
                          title: const Text('Thông tin cá nhân'),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () {
                            controller!.closeDrawer();
                            _showChangePasswordDialog(context);
                          },
                          title: const Text('Đổi mật khẩu'),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () {
                            controller!.closeDrawer();
                            Get.toNamed(Routes.examHistoryScreen);
                          },
                          title: const Text('Lịch sử làm bài'),
                        ),
                        const Divider(),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () {
                            controller!.closeDrawer();
                            Get.toNamed(Routes.aboutScreen);
                          },
                          title: const Text('Giới thiệu'),
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
                                    // Show a confirmation dialog
                                    bool? confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Đăng xuất'),
                                          content: const Text(
                                              'Bạn có chắc chắn muốn đăng xuất không?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text('Hủy'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text(
                                                'Đăng xuất',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (confirm == true) {
                                      await localDataController
                                          .deleteClientEmail();
                                      await localDataController
                                          .deleteClientFullName();
                                      await localDataController
                                          .deleteClientId();
                                      await localDataController
                                          .deleteClientAccessToken();
                                      await localDataController
                                          .deleteClientGradeId();
                                      await localDataController
                                          .deleteClientImageUrl();
                                      await localDataController
                                          .deleteClientLevelId();
                                      await localDataController
                                          .deleteClientPhoneNumber();
                                      await localDataController
                                          .deleteRegisterClientId();
                                      await localDataController
                                          .deleteClientRefreshToken();
                                      await localDataController
                                          .saveIsRememberMe(false);
                                      Get.offAllNamed(Routes.loginScreen);
                                    }
                                  },
                                  child: const Text('Đăng xuất')),
                            ),
                            TextButton(
                                onPressed: () async {
                                  _launchSupportURL();
                                },
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

  void _launchSupportURL() async {
    const urlString = 'https://facebook.com/zafus2103/';
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final authController = Get.put(AuthController());
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
                'Thay đổi ',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'mật khẩu',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  labelText: 'Mật khẩu cũ',
                ),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: 'Mật khẩu mới',
                ),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.library_add_check_outlined),
                  labelText: 'Xác nhận mật khẩu mới',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            SizedBox(
              height: 35,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  String oldPassword = oldPasswordController.text;
                  String newPassword = newPasswordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  if (newPassword.isEmpty ||
                      oldPassword.isEmpty ||
                      confirmPassword.isEmpty) {
                    Get.snackbar(
                        'Lỗi', 'Vui lòng nhập đầy đủ các trường yêu cầu');
                  } else if (newPassword == confirmPassword) {
                    await authController.changePassword(
                        oldPassword, newPassword);
                    Navigator.of(context).pop();
                  } else {
                    Get.snackbar('Lỗi', 'Mật khẩu không khớp');
                  }
                },
                child: Obx(
                  () => authController.isLoading.value
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Đổi mật khẩu',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPersonalInformationDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final authController = Get.put(AuthController());
    final localDataController = Get.put(LocalDataController());
    final gradeController = Get.put(GradeController());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        emailController.text = localDataController.clientEmail.value;
        fullNameController.text = localDataController.clientFullName.value;
        phoneNumberController.text =
            localDataController.clientPhoneNumber.value;

        return Obx(
          () {
            int gradeIdValue = localDataController.clientGradeId.value;
            return gradeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : AlertDialog(
                    surfaceTintColor: Colors.white,
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin ',
                          style: TextStyle(
                              color: ColorPalette.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'cá nhân',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email',
                          ),
                          readOnly: true,
                        ),
                        TextField(
                          readOnly: !authController.isChangingInformation.value
                              ? true
                              : false,
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_2_outlined),
                            labelText: 'Họ và tên',
                          ),
                        ),
                        TextField(
                          readOnly: !authController.isChangingInformation.value
                              ? true
                              : false,
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            labelText: 'Số điện thoại',
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                color: Colors.black,
                                'assets/images/grade_icon.png',
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          isExpanded: true,
                          value: localDataController.clientGradeId.value != -1
                              ? gradeController.gradeList
                                  .firstWhere((element) =>
                                      element.id ==
                                      localDataController.clientGradeId.value)
                                  .name
                              : null,
                          hint: Text(localDataController.clientGradeId.value ==
                                  -1
                              ? "Chọn lớp"
                              : gradeController.gradeList
                                  .firstWhere((grade) =>
                                      grade.id ==
                                      localDataController.clientGradeId.value)
                                  .name),
                          items: authController.isChangingInformation.value
                              ? gradeController.gradeList.map((grade) {
                                  return DropdownMenuItem<String>(
                                    value: grade.name,
                                    child: Text(grade.name),
                                  );
                                }).toList()
                              : null,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              final selectedGrade = gradeController.gradeList
                                  .firstWhere(
                                      (grade) => grade.name == newValue);
                              gradeIdValue = selectedGrade.id;
                            }
                          },
                        )
                      ],
                    ),
                    actions: !authController.isChangingInformation.value
                        ? [
                            TextButton(
                              onPressed: () {
                                authController.isChangingInformation.value =
                                    true;
                              },
                              child: const Text('Chỉnh sửa'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: Obx(
                                  () => authController.isLoading.value
                                      ? const Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          'Đóng',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ]
                        : [
                            TextButton(
                              onPressed: () {
                                authController.isChangingInformation.value =
                                    false;
                              },
                              child: const Text('Hủy'),
                            ),
                            SizedBox(
                              height: 35,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await authController
                                      .updatePersonalInformation(
                                          fullNameController.text,
                                          phoneNumberController.text,
                                          gradeIdValue);
                                  Navigator.of(context).pop();
                                },
                                child: Obx(
                                  () => authController.isLoading.value
                                      ? const Center(
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          'Lưu thay đổi',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            ),
                          ],
                  );
          },
        );
      },
    );
  }
}
