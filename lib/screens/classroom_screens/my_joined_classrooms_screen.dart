import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

import '../../models/classroom_models/classroom.dart';
import '../../widgets/list_view_container.dart';

class MyJoinedClassroomsScreen extends StatelessWidget {
  const MyJoinedClassroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = CustomDrawerController();

    final classroomController = Get.put(ClassroomController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(() => Column(
              children: [
                ClassroomAppBarContainer(
                  backAction: true,
                  drawerController: customDrawerController,
                  title: 'Lớp đang theo học',
                ),
                !classroomController.isLoading.value
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await classroomController.fetchMyClassrooms();
                          },
                          child: SingleChildScrollView(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ListViewContainer(
                                      title: 'Danh sách lớp bạn đang theo học',
                                      classroomList: classroomController
                                          .myJoinedClassrooms,
                                      numOfItems: classroomController
                                          .myJoinedClassrooms.length,
                                      func: (Classroom classroom) {
                                        classroomController.onChooseClassroom(
                                            classroom, false);
                                        Get.toNamed(Routes.classroomScreen);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            )));
  }
}
