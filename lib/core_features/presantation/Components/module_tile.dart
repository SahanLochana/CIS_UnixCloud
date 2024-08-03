import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_manegment_app/core_features/Data/Models/module_model.dart';
import 'package:student_manegment_app/Routes/route_constant.dart';

class ModuleTile extends StatelessWidget {
  // get moduleModel
  final ModuleModel moduleModel;
  const ModuleTile({
    super.key,
    required this.moduleModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to item page

        GoRouter.of(context).pushNamed(RouterConstants.itemsRouteName,
            pathParameters: {"moduleId": moduleModel.moduleId});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
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
              height: 52,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 100,
                child: Text(
                  moduleModel.moduleName,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
