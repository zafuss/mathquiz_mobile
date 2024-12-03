import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';

import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../widgets/classroom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/news_widget.dart';

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
                // AppBar luôn cố định ở trên cùng
                ClassroomAppBarContainer(
                  backAction: true,
                  drawerController: customDrawerController,
                  title: classroomController.chosenClassroom.value!.name!,
                  membersAction: true,
                ),
                Expanded(
                  // Cuộn nội dung bên dưới
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await classroomController
                          .fetchClassroomDetailListByClassroomId();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            !classroomController.isTeacher.value
                                ? SizedBox()
                                : _createNewsWidget(
                                    context, classroomController),
                            const SizedBox(height: kMinPadding),
                            classroomController.newsList.isEmpty
                                ? const Align(
                                    alignment: Alignment.center,
                                    child: const Text(
                                        'Lớp bạn chưa có bài viết nào'))
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        classroomController.newsList.length,
                                    itemBuilder: (context, index) => NewsWidget(
                                      classroomController: classroomController,
                                      news: classroomController.newsList[index],
                                      callback: () => classroomController
                                              .chosenNews.value =
                                          classroomController.newsList[index],
                                      isTeacher:
                                          classroomController.isTeacher.value,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Column _createNewsWidget(
      BuildContext context, ClassroomController classroomController) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();
    LocalDataController localDataController = Get.find<LocalDataController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bảng tin',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: kMinPadding / 3,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          onTap: () {
            showDialog(
                context: (context),
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Huỷ',
                              style: const TextStyle(
                                  color: ColorPalette.primaryColor),
                            )),
                        Obx(
                          () => classroomController.dialogLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await classroomController.createNews(
                                          _titleController.text,
                                          _contentController.text,
                                          context);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        ColorPalette.primaryColor, // Màu nền
                                    foregroundColor: Colors.white, // Màu chữ
                                  ),
                                  child: const Text('Đăng'),
                                ),
                        )
                      ],
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng ',
                            style: TextStyle(
                                color: ColorPalette.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'bài viết',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Tiêu đề',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextFormField(
                              controller: _titleController,
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tiêu đề không được để trống';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Nhập tiêu đề'),
                            ),
                            const SizedBox(
                              height: kMinPadding,
                            ),
                            const Text(
                              'Nội dung',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextFormField(
                              controller: _contentController,
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nội dung không được để trống';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Nhập nội dung cần đăng'),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorPalette.primaryColor),
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                color: Colors.white.withOpacity(0.6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMinPadding, vertical: kMinPadding / 1.5),
              child: Row(
                children: [
                  if (localDataController.clientImageUrl.value.isEmpty)
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.person_2_outlined),
                      ),
                    )
                  else
                    ClipOval(
                      child: Image.network(
                        localDataController.clientImageUrl.value,
                        fit: BoxFit.cover,
                        width: 45.0,
                        height: 45.0,
                      ),
                    ),
                  const SizedBox(
                    width: kMinPadding,
                  ),
                  const Expanded(
                    child: const Text(
                      'Thông báo gì đó cho lớp của bạn...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black38, fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
