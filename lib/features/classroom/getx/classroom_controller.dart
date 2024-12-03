import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mathquiz_mobile/features/auth/data/local_data_controller.dart';
import 'package:mathquiz_mobile/features/classroom/data/classroom/classroom_repository.dart';
import 'package:mathquiz_mobile/features/classroom/data/classroom_detail/classroom_detail_repository.dart';
import 'package:mathquiz_mobile/features/classroom/data/comment/comment_repository.dart';
import 'package:mathquiz_mobile/features/classroom/data/news/news_repository.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/comment/create_comment_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/news/create_news_dto.dart';
import 'package:mathquiz_mobile/features/classroom/dtos/news/update_news_dto.dart';
import 'package:mathquiz_mobile/helpers/data_loading.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom.dart';
import 'package:mathquiz_mobile/models/classroom_models/classroom_detail.dart';
import 'package:mathquiz_mobile/models/classroom_models/comments.dart';
import 'package:mathquiz_mobile/models/classroom_models/news.dart';
import 'package:mathquiz_mobile/result_type.dart';

class ClassroomController extends GetxController {
  Rx<DataLoading> joinClassroomLoading = Rx<DataLoading>(DataLoading());
  var dialogLoading = false.obs;
  var dialogMessage = ''.obs;
  var isLoading = false.obs;
  var isJoiningClassroom = false.obs;
  var isTeacher = false.obs;

  Rx<Classroom?> chosenClassroom = Rx<Classroom?>(null);
  Rx<News?> chosenNews = Rx<News?>(null);

  RxList<Classroom> myClassrooms = <Classroom>[].obs;
  RxList<Classroom> myJoinedClassrooms = <Classroom>[].obs;
  RxList<ClassroomDetail> classroomDetailList = <ClassroomDetail>[].obs;
  RxList<News> newsList = <News>[].obs;
  RxList<Comment> commentList = <Comment>[].obs;

  ClassroomRepository classroomRepository = ClassroomRepository();
  ClassroomDetailRepository classroomDetailRepository =
      ClassroomDetailRepository();
  NewsRepository newsRepository = NewsRepository();
  CommentRepository commentRepository = CommentRepository();
  LocalDataController localDataController = LocalDataController();

  @override
  void onInit() async {
    super.onInit();
    await fetchMyClassrooms();
    await fetchMyJoinedClassrooms();
  }

  onChooseClassroom(Classroom classroom, bool isTeacher) async {
    isLoading.value = true;
    chosenClassroom.value = classroom;
    this.isTeacher.value = isTeacher;
    await fetchClassroomDetailListByClassroomId();
    await fetchNewsList();
    isLoading.value = false;
  }

  fetchCommentList() async {
    isLoading.value = true;
    var result = await commentRepository.getByNews(chosenNews.value!.id);
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          commentList.value = result.data!,
          commentList.sort((a, b) => b.publishDate.compareTo(a.publishDate))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin bình luận.', result.message),
    });
  }

  createNews(String title, String content, BuildContext context) async {
    dialogLoading.value = true;
    CreateNewsDto news = CreateNewsDto(
        title: title, content: content, classroomId: chosenClassroom.value!.id);
    var result = await newsRepository.createNews(news);
    dialogLoading.value = false;
    return (switch (result) {
      Success() => {await fetchNewsList(), Navigator.of(context).pop()},
      Failure() => Get.snackbar('Lỗi tạo bài viết.', result.message),
    });
  }

  createNewsComment(String content) async {
    isLoading.value = true;
    String clientId = await localDataController.getClientId() ?? '';

    CreateCommentDto comment = CreateCommentDto(
        content: content, newsId: chosenNews.value!.id, clientId: clientId);
    var result = await commentRepository.createNewsComment(comment);
    isLoading.value = false;

    return (switch (result) {
      Success() => {await fetchCommentList()},
      Failure() => Get.snackbar('Lỗi thêm bình luận.', result.message),
    });
  }

  editNews(String id, String title, String content, BuildContext context,
      {bool isDeleted = false}) async {
    dialogLoading.value = true;
    UpdateNewsDto news = UpdateNewsDto(
        id: id, title: title, content: content, isDeleted: isDeleted);
    var result = await newsRepository.editNews(news);
    dialogLoading.value = false;
    return (switch (result) {
      Success() => {await fetchNewsList(), Navigator.of(context).pop()},
      Failure() => Get.snackbar('Lỗi chỉnh sửa bài viết.', result.message),
    });
  }

  fetchMyClassrooms() async {
    isLoading.value = true;
    var result = await classroomRepository.getMyClassrooms();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          myClassrooms.value = result.data!,
          myClassrooms.sort((a, b) => b.createDate.compareTo(a.createDate))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }

  fetchNewsList() async {
    isLoading.value = true;
    var result =
        await newsRepository.getNewsByClassroomId(chosenClassroom.value!.id);
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          newsList.value = result.data!,
          newsList.sort((a, b) => b.timeCreated.compareTo(a.timeCreated))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin bảng tin.', result.message),
    });
  }

  fetchClassroomDetailListByClassroomId() async {
    isLoading.value = true;
    var result = await classroomDetailRepository
        .getMyClassroomDetailsByClassroomId(chosenClassroom.value!.id);
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          classroomDetailList.value = result.data!,
          if (classroomDetailList.length > 1)
            {
              classroomDetailList.sort((a, b) =>
                  b.classroomRole.name.compareTo(a.classroomRole.name))
            },
        },
      Failure() =>
        Get.snackbar('Lỗi lấy thông tin chi tiết lớp học.', result.message),
    });
  }

  Future<Object> joinClassroom(String classroomId, BuildContext context) async {
    joinClassroomLoading.value.isLoading = true;
    var clientId = await localDataController.getClientId();
    var result = await classroomRepository.joinClassroom(
        clientId: clientId!, classroomId: classroomId);
    joinClassroomLoading.value.isLoading = false;
    return (switch (result) {
      Success() => {
          Navigator.of(context).pop(),
          Get.snackbar('Thông báo', "Tham gia lớp học thành công!"),
        },
      Failure() => {
          joinClassroomLoading.update((data) {
            data?.resultMessage = result.message;
          })
        }
    });
  }

  Future<Object> createClassroom(
      String classroomName, BuildContext context) async {
    dialogLoading.value = true;
    var clientId = await localDataController.getClientId();
    var result = await classroomRepository.createClassroom(
        clientId: clientId!, classroomName: classroomName);
    return (switch (result) {
      Success() => {
          dialogLoading.value = false,
          dialogMessage.value = result.data,
          result,
          await fetchMyClassrooms(),
          await fetchMyJoinedClassrooms(),
        },
      Failure() => {dialogLoading.value = true, result}
    });
  }

  Future<Object> changeIsDeletedStatus(String classroomDetailId) async {
    dialogLoading.value = true;

    var result = await classroomDetailRepository
        .changeIsDeletedStatus(classroomDetailId);
    return (switch (result) {
      Success() => {
          dialogLoading.value = false,
          dialogMessage.value = 'Xoá thành viên thành công!',
          result,
        },
      Failure() => {
          dialogLoading.value = true,
          dialogMessage.value = 'Lỗi xoá thành viên!',
          result
        }
    });
  }

  fetchMyJoinedClassrooms() async {
    isLoading.value = true;
    var result = await classroomRepository.getMyJoinedClassrooms();
    isLoading.value = false;
    return (switch (result) {
      Success() => {
          myJoinedClassrooms.value = result.data!,
          myJoinedClassrooms
              .sort((a, b) => b.createDate.compareTo(a.createDate))
        },
      Failure() => Get.snackbar('Lỗi lấy thông tin lớp học.', result.message),
    });
  }
}
