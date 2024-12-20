import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';

import 'package:mathquiz_mobile/widgets/classroom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

import '../../models/classroom_models/classroom.dart';

class ClassroomMembersScreen extends StatelessWidget {
  const ClassroomMembersScreen({super.key});

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
                  title: classroomController.isTeacher.value
                      ? InkWell(
                          onTap: () {
                            _showEditClassroomDialog(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                classroomController
                                    .chosenClassroom.value!.name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    fontSize: 24),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        )
                      : Text(
                          classroomController.chosenClassroom.value!.name!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        ),
                ),
                !classroomController.isLoading.value
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await classroomController
                                .fetchClassroomDetailListByClassroomId();
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
                                  classroomController.isTeacher.value
                                      ? Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Mã lớp: ',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    classroomController
                                                        .chosenClassroom
                                                        .value!
                                                        .id,
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  IconButton(
                                                    color: ColorPalette
                                                        .primaryColor,
                                                    icon:
                                                        const Icon(Icons.copy),
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                        text:
                                                            classroomController
                                                                .chosenClassroom
                                                                .value!
                                                                .id,
                                                      ));
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                            content: Text(
                                                                'Đã lưu mã lớp vào bộ nhớ tạm!')),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                  ClassroomMembersListView(
                                      title:
                                          'Thành viên (${classroomController.classroomDetailList.length})',
                                      numOfItems: classroomController
                                          .classroomDetailList.length,
                                      func: (Classroom classroom) {
                                        classroomController.onChooseClassroom(
                                            classroom, true);
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

  void _showEditClassroomDialog(BuildContext context) {
    final TextEditingController classroomNameController =
        TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final classroomController = Get.find<ClassroomController>();

    classroomNameController.text =
        classroomController.chosenClassroom.value!.name!;

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
                'Chỉnh sửa ',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Trường này không được để trống';
                    }
                    return null;
                  },
                  controller: classroomNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.create),
                    labelText: 'Tên lớp học',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Only wrap the parts that need updating with Obx
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
                    await classroomController.putClassroom(
                        classroomController.chosenClassroom.value!.id,
                        classroomNameController.text,
                        context);
                    // Perform the save operation or state update here
                    Navigator.of(context).pop();
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
                      : const Text(
                          'Sửa',
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

// ignore: must_be_immutable
class ClassroomMembersListView extends StatelessWidget {
  ClassroomMembersListView(
      {super.key,
      required this.title,
      required this.numOfItems,
      required this.func,
      this.seeAllFunc});

  final String title;
  ClassroomController classroomController = Get.find<ClassroomController>();
  final int numOfItems;
  final Function func;
  final Function? seeAllFunc;

  @override
  Widget build(BuildContext context) {
    LocalDataController localDataController = Get.find<LocalDataController>();
    return Obx(
      () => classroomController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                        seeAllFunc != null
                            ? InkWell(
                                child: const Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                      color: ColorPalette.primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                onTap: () => seeAllFunc!(),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: kMinPadding / 2,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: numOfItems,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: kMinPadding),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMinPadding / 2),
                              child: Column(
                                children: [
                                  const SizedBox(width: kMinPadding),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kMinPadding),
                                    child: Row(
                                      children: [
                                        classroomController
                                                    .classroomDetailList[index]
                                                    .client
                                                    .imageUrl ==
                                                null
                                            ? Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                      Icons.person_2_outlined),
                                                ),
                                              )
                                            : ClipOval(
                                                child: Image.network(
                                                  classroomController
                                                      .classroomDetailList[
                                                          index]
                                                      .client
                                                      .imageUrl!,
                                                  fit: BoxFit.cover,
                                                  width: 45.0,
                                                  height: 45.0,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: kMinPadding / 2,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: DefaultTextStyle
                                                                .of(context)
                                                            .style
                                                            .copyWith(
                                                                color: ColorPalette
                                                                    .primaryColor),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${classroomController.classroomDetailList[index].client.fullname}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold), // In đậm
                                                          ),
                                                          TextSpan(
                                                            text: localDataController
                                                                        .clientId
                                                                        .value ==
                                                                    classroomController
                                                                        .classroomDetailList[
                                                                            index]
                                                                        .client
                                                                        .id
                                                                ? ' (bạn)'
                                                                : '',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300), // In đậm
                                                          )
                                                        ],
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        classroomController
                                                                    .classroomDetailList[
                                                                        index]
                                                                    .classroomRole
                                                                    .name
                                                                    .trim() ==
                                                                'Teacher'
                                                            ? 'Giáo viên'
                                                            : 'Học sinh',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 13),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (classroomController
                                                .isTeacher.value &&
                                            localDataController
                                                    .clientId.value !=
                                                classroomController
                                                    .classroomDetailList[index]
                                                    .client
                                                    .id &&
                                            classroomController
                                                    .classroomDetailList[index]
                                                    .classroomRole
                                                    .name !=
                                                "Teacher")
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                              cardColor:
                                                  ColorPalette.backgroundColor,
                                              highlightColor:
                                                  ColorPalette.backgroundColor,
                                            ),
                                            child: _memberPopup(context, index),
                                          )
                                        else
                                          const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  PopupMenuButton<int> _memberPopup(BuildContext context, int index) {
    return PopupMenuButton<int>(
      surfaceTintColor: ColorPalette.backgroundColor,
      icon: const Icon(
        Icons.more_horiz_rounded,
        color: ColorPalette.primaryColor, // Màu sắc của icon
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("Xoá khỏi lớp"),
        ),
      ],
      onSelected: (value) async {
        // Xử lý khi chọn menu
        var dialogResult = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xoá ',
                  style: TextStyle(
                      color: ColorPalette.primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'thành viên',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: classroomController.dialogLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(color: ColorPalette.primaryColor),
                      children: [
                        const TextSpan(
                            text: 'Bạn chắc chắn muốn xoá ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text:
                              '${classroomController.classroomDetailList[index].client.fullname}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold), // In đậm
                        ),
                        const TextSpan(
                            text: ' ra khỏi lớp ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text:
                              '${classroomController.classroomDetailList[index].classroom.name}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold), // In đậm
                        ),
                        const TextSpan(
                            text: '?', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Xoá',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );

        if (dialogResult == true) {
          await classroomController.changeIsDeletedStatus(
              classroomController.classroomDetailList[index].id);

          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(classroomController.dialogMessage.value),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xoá ',
                          style: TextStyle(
                              color: ColorPalette.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'thành viên',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ));
          await classroomController.fetchClassroomDetailListByClassroomId();
        }
      },
    );
  }
}
