import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/widgets/news_widget.dart';

import '../../config/color_const.dart';
import '../../features/classroom/getx/classroom_controller.dart';
import '../../features/drawer/drawer_controller.dart';
import '../../helpers/classroom_datetime_formatter.dart';
import '../../models/classroom_models/comments.dart';
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
                      await classroomController.fetchCommentList();
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
    final _formKey = GlobalKey<FormState>();
    TextEditingController _contentController = TextEditingController();
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
                NewsInfoWidget(
                    classroomController: classroomController,
                    news: classroomController.chosenNews.value!),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kMinPadding / 2),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: ColorPalette.primaryColor,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _contentController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nội dung không được để trống';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.6),
                                hintText: 'Nhập bình luận...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorPalette
                                          .primaryColor), // Màu viền khi không focus
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorPalette
                                          .primaryColor), // Màu viền khi focus
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius))),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await classroomController
                                  .createNewsComment(_contentController.text);
                            }
                          },
                          icon: const Text(
                            'Gửi',
                            style: TextStyle(color: ColorPalette.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kMinPadding / 2,
                ),
                classroomController.commentList.isEmpty
                    ? const Center(
                        child: const Text('Chưa có bình luận nào'),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            border:
                                Border.all(color: ColorPalette.primaryColor),
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius)),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: classroomController.commentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kMinPadding / 2,
                                    vertical: kMinPadding / 2),
                                child: Row(children: [
                                  _avatarCircle(
                                      classroomController
                                          .commentList[index].client.imageUrl,
                                      35),
                                  const SizedBox(
                                    width: kMinPadding / 2,
                                  ),
                                  _clientCommentInfoWidget(
                                      classroomController.commentList[index]),
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

  Expanded _clientCommentInfoWidget(Comment comment) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  comment.client.fullname ?? 'null',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Text(
            classroomDateTimeFormatter(comment.publishDate),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black38, fontSize: 13),
          ),
          Text(
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              comment.content),
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
          padding: EdgeInsets.all(4.0),
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
