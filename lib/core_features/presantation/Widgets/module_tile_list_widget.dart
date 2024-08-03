import 'package:flutter/material.dart';
import 'package:student_manegment_app/core_features/Data/Models/module_model.dart';
import 'package:student_manegment_app/core_features/Data/Remote/firebase_services.dart';
import 'package:student_manegment_app/core_features/presantation/Components/loading_wave.dart';
import 'package:student_manegment_app/core_features/presantation/Components/module_tile.dart';

class ModuleListWidget extends StatelessWidget {
  const ModuleListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return FutureBuilder(
        future: services.getModules("modules"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWave());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          List<ModuleModel> moduleList = snapshot.data;
          return ListView.builder(
            itemCount: moduleList.length,
            itemBuilder: (BuildContext context, int index) {
              ModuleModel eachModuleModel = moduleList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ModuleTile(
                  moduleModel: eachModuleModel,
                ),
              );
            },
          );
        });
  }
}
