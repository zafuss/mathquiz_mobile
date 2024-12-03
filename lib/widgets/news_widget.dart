import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/routes.dart';
import 'package:mathquiz_mobile/features/classroom/getx/classroom_controller.dart';
import 'package:mathquiz_mobile/helpers/classroom_datetime_formatter.dart';
import 'package:mathquiz_mobile/models/classroom_models/news.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.classroomController,
    required this.news,
    required this.callback,
  });

  final ClassroomController classroomController;
  final News news;
  final Function callback;

  @override
  Widget build(BuildContext context) {
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
                    classroomController: classroomController, news: news),
                _commentButton(),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: kMinPadding,
        )
      ],
    );
  }

  Column _commentButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kMinPadding / 2),
          child: Container(
            width: double.infinity,
            height: 1,
            color: ColorPalette.primaryColor,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () async {
              callback();
              await classroomController.fetchCommentList();
              Get.toNamed(Routes.classroomNewsScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius)),
              child: const IntrinsicWidth(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(Icons.messenger_outline),
                      SizedBox(
                        width: kMinPadding / 3,
                      ),
                      Text('Bình luận'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsInfoWidget extends StatelessWidget {
  const NewsInfoWidget({
    super.key,
    required this.classroomController,
    required this.news,
  });

  final ClassroomController classroomController;
  final News news;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (classroomController.chosenClassroom.value!.teacher!.imageUrl ==
                null)
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
                  classroomController.chosenClassroom.value!.teacher!.imageUrl!,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          classroomController
                                  .chosenClassroom.value!.teacher!.fullname ??
                              classroomController
                                  .chosenClassroom.value!.teacher!.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      classroomController.isTeacher.value
                          ? PopupMenuButton<int>(
                              onSelected: (value) {
                                classroomController.chosenNews.value = news;
                                _titleController.text = news.title;
                                _contentController.text = news.content;

                                if (value == 1) {
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
                                                        color: ColorPalette
                                                            .primaryColor),
                                                  )),
                                              Obx(
                                                () => classroomController
                                                        .dialogLoading.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : TextButton(
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            await classroomController
                                                                .editNews(
                                                                    news.id,
                                                                    _titleController
                                                                        .text,
                                                                    _contentController
                                                                        .text,
                                                                    context);
                                                          }
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              ColorPalette
                                                                  .primaryColor, // Màu nền
                                                          foregroundColor: Colors
                                                              .white, // Màu chữ
                                                        ),
                                                        child: const Text(
                                                            'Xác nhận chỉnh sửa'),
                                                      ),
                                              )
                                            ],
                                            title: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Chỉnh sửa ',
                                                  style: TextStyle(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'bài viết',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            content: Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Tiêu đề',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _titleController,
                                                    maxLines: 1,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Tiêu đề không được để trống';
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Nhập tiêu đề'),
                                                  ),
                                                  const SizedBox(
                                                    height: kMinPadding,
                                                  ),
                                                  const Text(
                                                    'Nội dung',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _contentController,
                                                    maxLines: 3,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Nội dung không được để trống';
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Nhập nội dung cần đăng'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Xoá ',
                                                  style: TextStyle(
                                                      color: ColorPalette
                                                          .primaryColor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'bài viết',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            content: const Text(
                                                'Bạn có chắc chắn muốn xoá bài viết này không?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Huỷ',
                                                    style: const TextStyle(
                                                        color: ColorPalette
                                                            .primaryColor),
                                                  )),
                                              Obx(
                                                () => classroomController
                                                        .dialogLoading.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : TextButton(
                                                        onPressed: () async {
                                                          await classroomController
                                                              .editNews(
                                                                  news.id,
                                                                  _titleController
                                                                      .text,
                                                                  _contentController
                                                                      .text,
                                                                  context,
                                                                  isDeleted:
                                                                      true);
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          foregroundColor: Colors
                                                              .white, // Màu chữ
                                                        ),
                                                        child:
                                                            const Text('Xoá'),
                                                      ),
                                              )
                                            ],
                                          ));
                                }
                              },
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
                                  value: 2,
                                  child: Text("Xoá bài viết"),
                                ),
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                  Text(
                    classroomDateTimeFormatter(news.timeCreated),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black38, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: kMinPadding / 3,
        ),
        Text(
          news.title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          news.content,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
