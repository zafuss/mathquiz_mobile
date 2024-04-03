import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/bg_auth.png'),
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
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Khôi phục',
                  style: TextStyle(
                      height: 1,
                      fontSize: 40,
                      color: ColorPalette.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  'mật khẩu',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                const Text(
                  'Nhập Email của bạn bên dưới và chúng tôi sẽ gửi cho bạn một thư kèm theo hướng dẫn về cách thay đổi mật khẩu của bạn.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email của bạn'),
                ),
                const SizedBox(
                  height: kMinPadding,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Tiếp tục'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
