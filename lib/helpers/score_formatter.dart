num scoreFormatter(double input) {
  // Kiểm tra nếu giá trị có thể chuyển đổi thành int
  if (input == input.toInt()) {
    return input.toInt();
  }
  // Nếu không thể chuyển đổi thành int, trả về double với 2 chữ số thập phân
  return double.parse(input.toStringAsFixed(2));
}
