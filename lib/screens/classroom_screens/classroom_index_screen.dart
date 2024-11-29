import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          onPressed: () => _showOptions(context, classroomController),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.add),
        ),
        body: Obx(() => Column(
              children: [
                ClassroomAppBarContainer(
                  drawerController: customDrawerController,
                  title: 'Lớp học',
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
                            child: SizedBox(
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

  void _showOptions(
      BuildContext context, ClassroomController classroomController) {
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
                classroomController.dialogMessage.value = '';

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
    final _formKey = GlobalKey<FormState>();
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
          content: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  classroomController.dialogMessage.value.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(kMinPadding),
                              child: Text(
                                classroomController.dialogMessage.value,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: classroomController
                                          .dialogMessage.value));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Đã lưu mã lớp vào bộ nhớ tạm!')),
                                  );
                                },
                                child: const Icon(Icons.copy),
                              ),
                            ),
                          ],
                        )
                      : TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường này không được để trống';
                            }

                            return null; // Trả về null nếu không có lỗi
                          },
                          controller: classroomNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.create),
                            labelText: 'Nhập tên lớp học',
                          ),
                        ),
                ],
              ),
            ),
          ),
          actions: [
            Obx(
              () => classroomController.dialogMessage.value.isEmpty
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy'),
                    )
                  : const SizedBox(),
            ),
            SizedBox(
              height: 35,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    classroomController.dialogMessage.value.isEmpty
                        ? await classroomController.createClassroom(
                            classroomNameController.text, context)
                        : Navigator.of(context).pop();
                  }
                },
                child: Obx(
                  () => classroomController.dialogLoading.value
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          classroomController.dialogMessage.value.isNotEmpty
                              ? 'Đóng'
                              : 'Tạo',
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

  AlertDialog _classroomCreatedDialog(BuildContext context, String code) {
    return AlertDialog(
      title: const Text('Tạo lớp học thành công!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            code,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã lưu mã lớp vào bộ nhớ tạm!')),
              );
            },
            icon: const Icon(Icons.copy),
            label: const Text('Sao chép'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    );
  }

  void _showJoinClassroomDialog(BuildContext context) {
    final TextEditingController classroomNameController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final classroomController = Get.put(ClassroomController());
    classroomController.joinClassroomLoading.update((data) {
      data?.resultMessage = null;
    });
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
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: classroomNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    labelText: 'Nhập mã lớp học',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Trường này không được để trống';
                    }
                    if (value.length != 6) {
                      return 'Số ký tự phải là 6';
                    }
                    return null; // Trả về null nếu không có lỗi
                  },
                ),
                const SizedBox(
                  height: kMinPadding / 3,
                ),
                Obx(() => classroomController
                            .joinClassroomLoading.value.resultMessage ==
                        null
                    ? const SizedBox()
                    : Text(
                        classroomController
                            .joinClassroomLoading.value.resultMessage!,
                        style: const TextStyle(color: Colors.red),
                      ))
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                classroomController.joinClassroomLoading.value.resultMessage =
                    null;
              },
              child: const Text('Hủy'),
            ),
            SizedBox(
              height: 35,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    classroomController.joinClassroom(
                        classroomNameController.text, context);
                  }
                },
                child: Obx(
                  () => classroomController.joinClassroomLoading.value.isLoading
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
