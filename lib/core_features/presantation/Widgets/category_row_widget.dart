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
          tielIcon: Icons.video_file,
          title: "Notes",
          type: "Notes",
        ),
        SizedBox(
          width: 15,
        ),
        CatoTileRound(
          tielIcon: Icons.book,
          title: "Slides",
          type: "Slides",
        ),
        SizedBox(
          width: 15,
        ),
        CatoTileRound(
          tielIcon: Icons.book,
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
