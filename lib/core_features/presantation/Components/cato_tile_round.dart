import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:student_manegment_app/core_features/Provider/current_status_provider.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';

class CatoTileRound extends StatelessWidget {
  final IconData tielIcon;
  final String title;
  final String type;
  const CatoTileRound(
      {super.key,
      required this.tielIcon,
      required this.title,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            // store selected category
            value.typeUpdater(type);

            // navigate to module page
            GoRouter.of(context).pushNamed(RouterConstants.modulesRouteName);
          },
          child: SizedBox(
            width: 80,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 70,
                  width: 70,
                  child: Icon(tielIcon),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
