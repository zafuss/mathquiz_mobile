import 'package:intl/intl.dart';

String classroomDateTimeFormatter(DateTime date) {
  return DateFormat('HH:mm dd/MM/yyyy').format(date);
}
