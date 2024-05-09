import 'package:flutter/material.dart';
import 'package:mathquiz_mobile/config/color_const.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    top: kMinPadding / 2,
                    bottom: kMinPadding / 3),
                child: Text(
                  'Đề bạn đã làm gần đây',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                height: 105,
                width: double.infinity,
                color: Colors.white.withOpacity(0.8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: kDefaultPadding,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, right: 17),
                      child: Container(
                        width: 138,
                        decoration: BoxDecoration(
                            color: ColorPalette.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, right: 17),
                      child: Container(
                        width: 138,
                        decoration: BoxDecoration(
                            color: ColorPalette.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, right: 17),
                      child: Container(
                        width: 138,
                        decoration: BoxDecoration(
                            color: ColorPalette.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                top: kMinPadding / 2,
                bottom: kMinPadding / 3),
            child: Text(
              'Đề dành cho bạn',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 17,
                mainAxisSpacing: 17,
                childAspectRatio: 1.8,
                children: List.generate(
                  7,
                  (index) => Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
