import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';

import '../../config/color_const.dart';
import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../helpers/classroom_datetime_formatter.dart';
import '../../widgets/classroom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class ClassroomNewsScreen extends StatelessWidget {
  ClassroomNewsScreen({super.key});
  final customDrawerController = CustomDrawerController();
  final classroomController = Get.put(ClassroomController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: customDrawerController.scaffoldKey,
        drawer: CustomDrawer(
          controller: customDrawerController,
        ),
        body: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar luôn cố định ở trên cùng
                ClassroomAppBarContainer(
                  backAction: true,
                  drawerController: customDrawerController,
                  title: classroomController.chosenClassroom.value!.name!,
                ),
                Expanded(
                  // Cuộn nội dung bên dưới
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await classroomController.fetchNewsList();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: kMinPadding),
                            _newsAndCommentsWidget(classroomController)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Column _newsAndCommentsWidget(ClassroomController classroomController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: ColorPalette.primaryColor),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              color: Colors.white.withOpacity(0.6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMinPadding, vertical: kMinPadding / 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  _avatarCircle(
                      classroomController
                              .chosenClassroom.value!.teacher!.imageUrl ??
                          null,
                      45),
                  const SizedBox(
                    width: kMinPadding / 2,
                  ),
                  _clientInfoWidget(),
                ]),
                const SizedBox(
                  height: kMinPadding / 3,
                ),
                Text(
                  classroomController.chosenNews.value!.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  classroomController.chosenNews.value!.content,
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kMinPadding / 2),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: ColorPalette.primaryColor,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      suffix: const Text(
                        'Gửi',
                        style: TextStyle(color: ColorPalette.primaryColor),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      hintText: 'Nhập bình luận...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorPalette
                                .primaryColor), // Màu viền khi không focus
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorPalette
                                .primaryColor), // Màu viền khi focus
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius))),
                ),
                const SizedBox(
                  height: kMinPadding / 2,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      border: Border.all(color: ColorPalette.primaryColor),
                      borderRadius: BorderRadius.circular(defaultBorderRadius)),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMinPadding / 2,
                              vertical: kMinPadding / 2),
                          child: Row(children: [
                            // _avatarCircle(
                            //     localDataController.clientImageUrl.value, 35),
                            const SizedBox(
                              width: kMinPadding / 2,
                            ),
                            _clientCommentInfoWidget(),
                          ]),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: kMinPadding,
        ),
      ],
    );
  }

  Expanded _clientInfoWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  classroomController.chosenClassroom.value!.teacher!.fullname!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              PopupMenuButton<int>(
                child: const Icon(
                  Icons.more_vert_outlined,
                  size: 20,
                  color: ColorPalette.primaryColor,
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Chỉnh sửa bài viết"),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Xoá bài viết"),
                  ),
                ],
              )
            ],
          ),
          Text(
            classroomDateTimeFormatter(
                classroomController.chosenNews.value!.timeCreated),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black38, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Expanded _clientCommentInfoWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Tên người bình luận',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Text(
            classroomDateTimeFormatter(DateTime.now()),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black38, fontSize: 13),
          ),
          const Text(
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              '''Lorem ipsum dolor sit amet Nam quis hendrerit magna. '''),
        ],
      ),
    );
  }

  Widget _avatarCircle(String? clientImageUrl, double size) {
    if (clientImageUrl == null) {
      return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.person_2_outlined),
        ),
      );
    } else {
      return ClipOval(
        child: Image.network(
          clientImageUrl,
          fit: BoxFit.cover,
          width: size,
          height: size,
        ),
      );
    }
  }
}
