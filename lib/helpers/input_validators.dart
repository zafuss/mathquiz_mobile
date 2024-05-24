import 'dart:core';

class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    // Kiểm tra định dạng email bằng biểu thức chính quy
    String emailPattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Định dạng email chuẩn
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    // Kiểm tra độ dài mật khẩu
    if (value.length < 8) {
      return 'Mật khẩu phải chứa ít nhất 8 ký tự';
    }

    // Kiểm tra có ít nhất một chữ hoa, một chữ thường, một số và một ký tự đặc biệt
    RegExp digitRegex = RegExp(r'[0-9]');
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    RegExp upperCaseRegex = RegExp(r'[A-Z]');
    RegExp specialCharRegex = RegExp(r'[@#\$%^&+=]');

    if (!digitRegex.hasMatch(value) ||
        !lowerCaseRegex.hasMatch(value) ||
        !upperCaseRegex.hasMatch(value) ||
        !specialCharRegex.hasMatch(value)) {
      return 'Mật khẩu phải chứa ít nhất một chữ hoa, một chữ thường, một số và một ký tự đặc biệt';
    }

    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã OTP';
    }
    if (value.length != 6) {
      return 'Mã OTP phải chứa đúng 6 ký tự';
    }
    if (int.tryParse(value) == null) {
      return 'Mã OTP chỉ được chứa số';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    // Bất kỳ điều kiện nào khác bạn muốn kiểm tra ở đây
    return null; // Trả về null nếu hợp lệ
  }
}
