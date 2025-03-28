import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/auth/getx/auth_controller.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/grade_controller.dart';
import 'package:mathquiz_mobile/helpers/input_validators.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final fullNameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final localDataController = Get.put(LocalDataController());
    final gradeController = Get.put(GradeController());
    int gradeIdValue = -1;
    emailController.text = localDataController.clientEmail.value == 'null' ||
            localDataController.clientEmail.value.isEmpty
        ? ''
        : localDataController.clientEmail.value;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => gradeController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 40,
                                        color: ColorPalette.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'tài khoản',
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding / 2,
                                  ),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Tooltip(
                                          message: 'Nhập email của bạn',
                                          child: TextFormField(
                                            controller: emailController,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              prefixIcon: Icon(
                                                Icons.email_outlined,
                                              ),
                                              hintText: "Email",
                                            ),
                                            validator: (value) =>
                                                InputValidator.validateEmail(
                                                    value),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        Tooltip(
                                          message: 'Nhập họ và tên của bạn',
                                          child: TextFormField(
                                            controller: fullNameController,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              prefixIcon: Icon(
                                                Icons.person,
                                              ),
                                              hintText: "Họ và tên",
                                            ),
                                            validator: (value) =>
                                                InputValidator.validateFullName(
                                                    value),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        Tooltip(
                                          message: 'Chọn lớp của bạn',
                                          child: Obx(() {
                                            gradeIdValue = authController
                                                .registerGradeId.value;
                                            return DropdownButtonFormField<
                                                    String>(
                                                decoration: InputDecoration(
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Image.asset(
                                                      color: Colors.black,
                                                      'assets/images/grade_icon.png',
                                                      width: 10,
                                                      height: 10,
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                value: authController.registerGradeId.value !=
                                                        -1
                                                    ? gradeController.gradeList
                                                        .firstWhere((element) =>
                                                            element.id ==
                                                            authController
                                                                .registerGradeId
                                                                .value)
                                                        .name
                                                    : null,
                                                hint: Text(localDataController
                                                            .clientGradeId
                                                            .value ==
                                                        -1
                                                    ? "Chọn lớp"
                                                    : gradeController.gradeList
                                                        .firstWhere((grade) =>
                                                            grade.id ==
                                                            localDataController
                                                                .clientGradeId
                                                                .value)
                                                        .name),
                                                items: gradeController.gradeList
                                                    .where((grade) => grade.id < 16)
                                                    .map((grade) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: grade.name,
                                                    child: Text(grade.id <= 12
                                                        ? grade.name
                                                        : "Đại học"),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
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
                                                });
                                          }),
                                        ),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        Tooltip(
                                          message: 'Nhập mật khẩu của bạn',
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: true,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              prefixIcon: Icon(
                                                Icons.key_outlined,
                                              ),
                                              hintText: "Mật khẩu",
                                            ),
                                            validator: (value) =>
                                                InputValidator.validatePassword(
                                                    value),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: kMinPadding / 2,
                                        ),
                                        Tooltip(
                                          message: 'Xác nhận mật khẩu của bạn',
                                          child: TextFormField(
                                            controller:
                                                confirmPasswordController,
                                            obscureText: true,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(top: 0),
                                              prefixIcon: Icon(
                                                Icons.lock_outline,
                                              ),
                                              hintText: "Xác nhận mật khẩu",
                                            ),
                                            validator: (value) {
                                              if (value !=
                                                  passwordController.text) {
                                                return 'Mật khẩu không khớp';
                                              }
                                              return InputValidator
                                                  .validatePassword(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  Semantics(
                                    button: true,
                                    label: 'Đăng ký',
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          authController.register(
                                              emailController.text,
                                              passwordController.text,
                                              fullNameController.text,
                                              gradeIdValue);
                                        }
                                      },
                                      child: authController.isLoading.value
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('Đăng ký'),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: kMinPadding, left: kDefaultPadding, right: kDefaultPadding),
        child: Semantics(
          button: true,
          label: 'Chuyển đến trang đăng nhập',
          child: TextButton(
            onPressed: () {
              authController.toLogin();
            },
            child: const Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "Bạn đã có tài khoản? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Đăng nhập",
                  style: TextStyle(
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
