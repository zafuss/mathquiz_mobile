import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

import '../../models/classroom_models/classroom.dart';
import '../../widgets/list_view_container.dart';

class MyClassroomsScreen extends StatelessWidget {
  const MyClassroomsScreen({super.key});

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
                  title: 'Quản lý lớp học',
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
                                      title:
                                          'Danh sách lớp học bạn đang quản lý',
                                      classroomList:
                                          classroomController.myClassrooms,
                                      numOfItems: classroomController
                                          .myClassrooms.length,
                                      func: (Classroom classroom) async {
                                        await classroomController
                                            .onChooseClassroom(classroom, true);
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
