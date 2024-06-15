import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  void _launchEmail(BuildContext context) async {
    final Email email = Email(
      body: '',
      subject: '',
      recipients: ['vuavanho283@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error sending email: $error');
      _showNoEmailClientDialog(context);
    }
  }

  void _showNoEmailClientDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Email Client Found'),
          content: const Text(
              'No email clients are installed on this device. Please install an email app to send emails.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _launchSupportURL() async {
    const urlString = 'https://facebook.com/zafus2103/';
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  void _launchWebsiteURL() async {
    const urlString = 'http://onluyentoan.online/';
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg_auth.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Math",
                              style: TextStyle(
                                fontSize: 40,
                                color: ColorPalette.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "Quiz",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Version 1.0.0',
                        style: TextStyle(height: 1.5, fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: kMinPadding,
                      ),
                      const Text(
                        'Ứng dụng thi trắc nghiệm Toán cho học sinh, sinh viên, được xây dựng và phát triển bởi zafus.',
                        style: TextStyle(height: 1.5, fontSize: 16.0),
                      ),
                      const SizedBox(height: kMinPadding * 2),
                      const Text(
                        'Phiên bản web',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      IconButton(
                          onPressed: _launchWebsiteURL,
                          icon: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.web,
                                color: ColorPalette.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('onluyentoan.online'),
                            ],
                          )),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      const Text(
                        'Liên hệ chúng tôi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _launchEmail(context),
                              icon: const Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: ColorPalette.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Email"),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _launchSupportURL(),
                              icon: const Row(
                                children: [
                                  Icon(
                                    Icons.facebook,
                                    color: ColorPalette.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Facebook"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
