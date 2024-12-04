import 'package:intl/intl.dart';

String classroomDateTimeFormatter(DateTime date) {
  return DateFormat('HH:mm dd/MM/yyyy').format(date);
}

String convertDateTime(DateTime dateTime) {
  // Định dạng lại theo chuẩn ISO 8601 với chữ "Z" ở cuối
  String formattedDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);

  return formattedDate;
}
