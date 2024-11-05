import 'package:flutter/material.dart';
import 'package:mathquiz_mobile/config/demension_const.dart';
import 'package:mathquiz_mobile/config/media_query_config.dart';
import 'package:mathquiz_mobile/features/choose_exam/dtos/ranking_dto.dart';
import 'package:mathquiz_mobile/helpers/score_formatter.dart';

import '../config/color_const.dart';

Column rankingWidget(List<RankingDto> ranking, double ratio) {
  return Column(
    children: [
      Center(
        child: Container(
            decoration: BoxDecoration(
                color: ColorPalette.primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: kMinPadding / 4, horizontal: kMinPadding),
              child: Text(
                'Bảng xếp hạng',
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
      const SizedBox(height: kMinPadding / 3),
      ranking.isEmpty
          ? const Text(
              'Chưa có thí sinh nào hoàn thành bài thi. Hãy là người đầu tiên!')
          : SizedBox(
              height: SizeConfig.screenHeight! / ratio,
              child: ListView.builder(
                  itemCount: ranking.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kMinPadding),
                            color: index == 0
                                ? const Color.fromRGBO(253, 246, 75, 0.6)
                                : Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kMinPadding / 2,
                              vertical: kMinPadding / 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 24,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorPalette.primaryColor),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                        color: ColorPalette.primaryColor),
                                  ),
                                ),
                              ),
                              Text(
                                ranking[index].fullName,
                                style: const TextStyle(
                                    color: ColorPalette.primaryColor),
                              ),
                              Text(
                                '${scoreFormatter(ranking[index].score)}',
                                style: const TextStyle(
                                    color: ColorPalette.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    ],
  );
}
