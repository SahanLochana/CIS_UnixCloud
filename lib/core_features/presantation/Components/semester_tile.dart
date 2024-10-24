import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SemesterTile extends StatelessWidget {
  final String semName;
  final String semNo;
  const SemesterTile({super.key, required this.semName, required this.semNo});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            // navigate to semester page
            value.semUpdater(semNo);
            GoRouter.of(context).pushNamed(
              RouterConstants.modulesRouteName,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                      ),
                    ),
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 100,
                      child: Text(
                        semName,
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 16,
                            fontFamily: "dmsans"),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
