import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/movie_detail_model.dart';
import 'movie_cast.dart';

class MovieDetailContentMainCast extends StatelessWidget {
  final showPanel = false.obs;
  final MovieDetailModel? movie;
  MovieDetailContentMainCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: context.themeGrey,
        ),
        Obx(() {
          return ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              showPanel.toggle();
            },
            children: [
              ExpansionPanel(
                canTapOnHeader: false,
                backgroundColor: Colors.white,
                isExpanded: showPanel.value,
                headerBuilder: (context, isExpanded) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elenco Principal',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        movie?.cast.map((c) => MovieCast(cast: c)).toList() ??
                            [],
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
