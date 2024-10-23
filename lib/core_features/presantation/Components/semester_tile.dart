import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SemesterTile extends StatelessWidget {
  final String semName;
  const SemesterTile({super.key, required this.semName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to semester page

        GoRouter.of(context).pushNamed(
          RouterConstants.itemsRouteName,
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
  }
}
