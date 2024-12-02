import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../widgets/classroom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({super.key});

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
                  drawerController: customDrawerController,
                  title: classroomController.chosenClassroom.value!.name!,
                  backAction: true,
                  membersAction: true,
                ),
                !classroomController.isLoading.value
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await classroomController.fetchMyClassrooms();
                            await classroomController.fetchMyJoinedClassrooms();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
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
