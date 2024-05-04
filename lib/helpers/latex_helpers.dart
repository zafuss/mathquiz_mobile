import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

Widget renderTextAndLaTeX(String inputString) {
  // Tạo danh sách các widget từ chuỗi đầu vào
  List<Widget> widgets = [];

  // Biểu thức chính quy để tìm các phần LaTeX trong chuỗi
  RegExp regex = RegExp(r'\$.*?\$');

  // Vị trí bắt đầu tìm kiếm tiếp theo
  int start = 0;

  // Tìm kiếm và trích xuất các phần LaTeX từ chuỗi
  Iterable<Match> matches = regex.allMatches(inputString);
  for (Match match in matches) {
    // Thêm phần văn bản thông thường từ vị trí trước phần LaTeX
    String textPart = inputString.substring(start, match.start);
    if (textPart.isNotEmpty) {
      widgets.add(Text(
        textPart,
      ));
    }

    // Trích xuất và xử lí phần LaTeX
    String latexPart = match.group(0)!;
    latexPart = latexPart.replaceAll(r'$', ''); // Xoá dấu $$
    // latexPart = r"""\( \ce{""" + latexPart + r"""} \)"""; // Tạo chuỗi LaTeX

    widgets.add(Math.tex(latexPart));
    // Thêm phần LaTeX vào danh sách các widget

    // Cập nhật vị trí bắt đầu tìm kiếm tiếp theo
    start = match.end;
  }

  // Thêm phần văn bản thông thường cuối cùng (nếu có)
  String lastTextPart = inputString.substring(start);
  if (lastTextPart.isNotEmpty) {
    widgets.add(Text(
      lastTextPart,
    ));
  }

  // Sử dụng Wrap để xếp các widget con trong hàng
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: widgets,
  );
}
