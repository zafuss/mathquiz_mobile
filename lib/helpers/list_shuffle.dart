import 'dart:math';

void shuffle<T>(List<T> list) {
  final random = Random();
  for (int i = list.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    // Hoán đổi vị trí phần tử
    var temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}
