import 'package:flutter/material.dart';

import '../config/color_const.dart';
import '../config/demension_const.dart';
import '../models/classroom_models/classroom.dart';

class ListViewContainer extends StatelessWidget {
  const ListViewContainer(
      {super.key,
      required this.title,
      required this.classroomList,
      required this.numOfItems,
      required this.func,
      this.seeAllFunc});

  final String title;
  final List<Classroom> classroomList;
  final int numOfItems;
  final Function func;
  final Function? seeAllFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kMinPadding / 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                classroomList.isNotEmpty
                    ? InkWell(
                        child: const Text(
                          'Xem tất cả',
                          style: TextStyle(
                              color: ColorPalette.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () => seeAllFunc!(),
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(
              height: kMinPadding / 2,
            ),
            classroomList.isEmpty
                // ignore: prefer_const_constructors
                ? Center(
                    child: const Text('Chưa có lớp học nào!'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    itemCount: numOfItems,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: kMinPadding),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () async {
                            func(classroomList[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: kMinPadding / 2),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                          width:
                                              kMinPadding), // thêm khoảng cách giữa ảnh và văn bản
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '${classroomList[index].name}',
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold), // In đậm
                                                  ),
                                                ],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/people_icon.png',
                                                      width: 12,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      classroomList[index]
                                                                  .teacher !=
                                                              null
                                                          ? classroomList[index]
                                                              .teacher!
                                                              .fullname!
                                                              .trim()
                                                          : 'null',
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: kMinPadding / 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      '·',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '${classroomList[index].numOfMembers} thành viên',
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
