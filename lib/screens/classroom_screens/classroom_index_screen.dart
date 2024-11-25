import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

import '../../config/color_const.dart';
import '../../models/classroom_models/classroom.dart';

class ClassroomIndexScreen extends StatelessWidget {
  const ClassroomIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = CustomDrawerController();

    final classroomController = Get.put(ClassroomController());
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: ColorPalette.primaryColor,
          onPressed: () => _showOptions(context),
          child: const Icon(Icons.add),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        body: Obx(() => Column(
              children: [
                ClassroomAppBarContainer(
                  drawerController: customDrawerController,
                ),
                !classroomController.isLoading.value
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {},
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Container(
                              height: SizeConfig.screenHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  listViewContainer(
                                      'Quản lý lớp học',
                                      classroomController.myClassrooms,
                                      () => Get.toNamed(Routes.aboutScreen)),
                                  const SizedBox(
                                    height: kMinPadding,
                                  ),
                                  listViewContainer(
                                      'Lớp học của bạn',
                                      classroomController.myJoinedClassrooms,
                                      () => Routes.aboutScreen)
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

  Container listViewContainer(
      String title, List<Classroom> classroomList, Function func) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kMinPadding / 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                InkWell(
                  child: const Text(
                    'Xem tất cả',
                    style: TextStyle(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () => func(),
                )
              ],
            ),
            const SizedBox(
              height: kMinPadding / 2,
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: classroomList.isEmpty
                  ? 0
                  : classroomList.length > 1
                      ? 2
                      : 1,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: kMinPadding),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kMinPadding / 2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                    width:
                                        kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style
                                              .copyWith(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '${classroomList[index].name}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold), // In đậm
                                            ),
                                          ],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/people_icon.png',
                                                width: 12,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                classroomList[index]
                                                    .teacherFullName,
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: kMinPadding,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                '·',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                '${classroomList[index].numOfMembers} thành viên',
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionDialog(BuildContext context, String option) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bạn đã chọn'),
          content: Text(option),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tạo lớp học mới'),
              onTap: () {
                Navigator.of(context).pop();
                _showCreateClassroomDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group_add_outlined),
              title: const Text('Tham gia lớp học'),
              onTap: () {
                Navigator.of(context).pop();
                _showJoinClassroomDialog(context);
              },
            ),
            const SizedBox(
              height: kMinPadding,
            ),
          ],
        );
      },
    );
  }

  void _showCreateClassroomDialog(BuildContext context) {
    final TextEditingController classroomNameController =
        TextEditingController();
    final classroomController = Get.put(ClassroomController());
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
                'Tạo ',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'lớp học',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: classroomNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.create),
                  labelText: 'Nhập tên lớp học',
                ),
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
                onPressed: () async {},
                child: Obx(
                  () => classroomController.isLoading.value
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
                          'Tạo',
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

  void _showJoinClassroomDialog(BuildContext context) {
    final TextEditingController classroomNameController =
        TextEditingController();
    final classroomController = Get.put(ClassroomController());
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
                'Tham gia ',
                style: TextStyle(
                    color: ColorPalette.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'lớp học',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: classroomNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  labelText: 'Nhập mã lớp học',
                ),
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
                onPressed: () async {},
                child: Obx(
                  () => classroomController.isLoading.value
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
                          'Tham gia',
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
}
