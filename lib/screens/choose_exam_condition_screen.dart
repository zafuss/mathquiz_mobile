import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/features/choose_exam/getx/level_controller.dart';
import 'package:mathquiz_mobile/models/level.dart';

import '../config/demension_const.dart';

class ChooseExamConditionScreen extends StatelessWidget {
  const ChooseExamConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levelController = Get.put(LevelController());
    final items = ['Cấp 1', 'Cấp 2', 'Cấp 3'];
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Chọn ",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "đề thi",
                      style: TextStyle(
                          fontSize: 40,
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                Text('Cấp học'),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => levelController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Level>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints: BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor: Color.fromRGBO(251, 252, 253, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: levelController
                              .chosenLevel.value, // Default value
                          onChanged: (Level? newValue) {
                            // Handle dropdown value changes
                            print(newValue);
                          },
                          items: levelController.levelList
                              .map<DropdownMenuItem<Level>>((Level value) {
                            return DropdownMenuItem<Level>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(
                  height: kMinPadding,
                ),
                Text('Lớp'),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => levelController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Level>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints: BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor:
                                ColorPalette.primaryColor.withOpacity(0.3),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: levelController
                              .chosenLevel.value, // Default value
                          onChanged: (Level? newValue) {
                            // Handle dropdown value changes
                            print(newValue);
                          },
                          items: levelController.levelList
                              .map<DropdownMenuItem<Level>>((Level value) {
                            return DropdownMenuItem<Level>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(
                  height: kMinPadding,
                ),
                Text('Chương'),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => levelController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<Level>(
                          itemHeight: null,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            constraints: BoxConstraints.expand(height: 30),
                            filled: true,
                            fillColor: Color.fromRGBO(251, 252, 253, 1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          value: levelController
                              .chosenLevel.value, // Default value
                          onChanged: (Level? newValue) {
                            // Handle dropdown value changes
                            print(newValue);
                          },
                          items: levelController.levelList
                              .map<DropdownMenuItem<Level>>((Level value) {
                            return DropdownMenuItem<Level>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                ),
                SizedBox(
                  height: kMinPadding + 10,
                ),
                ElevatedButton(onPressed: () {}, child: Text('Tiếp tục'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
