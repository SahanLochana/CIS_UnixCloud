import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/presantation/Components/cato_tile_round.dart';

class CategoryRowWidget extends StatelessWidget {
  const CategoryRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CatoTileRound(
          assetsPath: "assets\\icons\\document.png",
          title: "Notes",
          type: "Notes",
        ),
        SizedBox(
          width: 15,
        ),
        CatoTileRound(
          assetsPath: "assets\\icons\\slide.png",
          title: "Slides",
          type: "Slides",
        ),
        SizedBox(
          width: 15,
        ),
        CatoTileRound(
          assetsPath: "assets\\icons\\resource.png",
          title: "Resouces",
          type: "resouces",
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
