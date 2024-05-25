import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';

import '../../features/auth/data/local_data_controller.dart';
import '../../features/choose_exam/getx/grade_controller.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final AuthController authController = Get.put(AuthController());
    final LocalDataController localDataController =
        Get.put(LocalDataController());
    final GradeController gradeController = Get.put(GradeController());
    emailController.text = localDataController.clientEmail.value;
    fullNameController.text = localDataController.clientFullName.value;
    phoneNumberController.text = localDataController.clientPhoneNumber.value;
    int gradeIdValue = localDataController.clientGradeId.value;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Obx(
            () => gradeController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min, // Add this line
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                      height:
                                          kDefaultPadding), // Add padding at the top
                                  const Text(
                                    "Thông tin ",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    "cá nhân",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 40,
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: kMinPadding,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await authController.pickImage();
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: CircleAvatar(
                                                  radius: 60,
                                                  backgroundColor: Colors.white,
                                                  child: !authController
                                                          .isUploadingAvatar
                                                          .value
                                                      ? localDataController
                                                              .clientImageUrl
                                                              .value
                                                              .isEmpty
                                                          ? const Icon(
                                                              Icons
                                                                  .person_2_outlined,
                                                              size: 50,
                                                              color: ColorPalette
                                                                  .primaryColor,
                                                            )
                                                          : ClipOval(
                                                              child:
                                                                  Image.network(
                                                                localDataController
                                                                    .clientImageUrl
                                                                    .value,
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 120.0,
                                                                height: 120.0,
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Icon(
                                                      Icons.edit_outlined,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                      TextField(
                                        readOnly: !authController
                                            .isChangingInformation.value,
                                        controller: fullNameController,
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.person_2_outlined),
                                          labelText: 'Họ và tên',
                                        ),
                                      ),
                                      const SizedBox(height: kMinPadding / 2),
                                      TextField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          labelText: 'Email',
                                        ),
                                        readOnly: true,
                                      ),
                                      const SizedBox(height: kMinPadding / 2),
                                      TextField(
                                        readOnly: !authController
                                            .isChangingInformation.value,
                                        controller: phoneNumberController,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.phone_android_outlined),
                                          labelText: 'Số điện thoại',
                                        ),
                                      ),
                                      const SizedBox(
                                          height: kMinPadding * 0.75),
                                      Obx(() {
                                        gradeIdValue = localDataController
                                            .clientGradeId.value;
                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image.asset(
                                                color: Colors.black,
                                                'assets/images/grade_icon.png',
                                                width: 10,
                                                height: 10,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          value: localDataController
                                                      .clientGradeId.value !=
                                                  -1
                                              ? gradeController.gradeList
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      localDataController
                                                          .clientGradeId.value)
                                                  .name
                                              : null,
                                          hint: Text(localDataController
                                                      .clientGradeId.value ==
                                                  -1
                                              ? "Chọn lớp"
                                              : gradeController.gradeList
                                                  .firstWhere((grade) =>
                                                      grade.id ==
                                                      localDataController
                                                          .clientGradeId.value)
                                                  .name),
                                          items: authController
                                                  .isChangingInformation.value
                                              ? gradeController.gradeList
                                                  .map((grade) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: grade.name,
                                                    child: Text(grade.name),
                                                  );
                                                }).toList()
                                              : null,
                                          onChanged: authController
                                                  .isChangingInformation.value
                                              ? (String? newValue) {
                                                  if (newValue != null) {
                                                    final selectedGrade =
                                                        gradeController
                                                            .gradeList
                                                            .firstWhere(
                                                                (grade) =>
                                                                    grade
                                                                        .name ==
                                                                    newValue);
                                                    gradeIdValue =
                                                        selectedGrade.id;
                                                  }
                                                }
                                              : null,
                                        );
                                      }),
                                      const SizedBox(height: kDefaultPadding),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(() {
                            return authController.isChangingInformation.value
                                ? Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await authController
                                              .updatePersonalInformation(
                                                  fullNameController.text,
                                                  phoneNumberController.text,
                                                  gradeIdValue);
                                          authController.isChangingInformation
                                              .value = false;
                                        },
                                        child: authController.isLoading.value
                                            ? const Center(
                                                child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : const Text('Lưu thay đổi'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          authController.isChangingInformation
                                              .value = false;
                                        },
                                        child: const Text('Hủy'),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        authController
                                            .isChangingInformation.value = true;
                                      },
                                      child: const Text('Chỉnh sửa'),
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
