import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/features/auth/otp/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Positioned(
                child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nhập mã gồm 6 chữ số đã được gửi dến a***@gmail.com'),
                    SizedBox(height: kDefaultPadding / 2),
                    TextField(),
                    SizedBox(height: kDefaultPadding / 2),
                    Obx(() => Text(
                        'Bạn chưa nhận được mã? Nhận mã mới trong ${otpController.countdown} giây.')),
                  ],
                )),
                ElevatedButton(onPressed: () {}, child: Text('Tiếp tục'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
