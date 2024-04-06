import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathquiz_mobile/features/drawer/drawer_controller.dart';
import 'package:mathquiz_mobile/widgets/custom_appbar.dart';
import 'package:mathquiz_mobile/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final customDrawerController = CustomDrawerController();

    return Scaffold(
      key: customDrawerController.scaffoldKey,
      appBar: CustomAppBar(
        drawerController: customDrawerController,
      ),
      drawer: CustomDrawer(
        controller: customDrawerController,
      ),
    );
  }
}
