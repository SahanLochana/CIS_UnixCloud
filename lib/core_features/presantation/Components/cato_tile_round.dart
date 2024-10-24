import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CatoTileRound extends StatelessWidget {
  final String assetsPath;
  final String title;
  final String type;
  const CatoTileRound(
      {super.key,
      required this.assetsPath,
      required this.title,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            // store selected category.
            value.typeUpdater(type);

            // navigate to module page
            GoRouter.of(context)
                .pushNamed(RouterConstants.semestersPageRouteName);
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
                  child: SizedBox(
                    child: Center(
                      child: Image.asset(
                        height: 35,
                        width: 35,
                        assetsPath,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: "dmsans"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
