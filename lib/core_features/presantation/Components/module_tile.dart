import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/Data/Models/module_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                    moduleModel.moduleName,
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
