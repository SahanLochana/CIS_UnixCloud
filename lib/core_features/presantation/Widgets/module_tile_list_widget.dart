import 'package:CIS_UnixCloud/core_features/Data/Models/module_model.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/firebase_services.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/module_tile.dart';
import 'package:flutter/material.dart';

class ModuleListWidget extends StatelessWidget {
  final String semName;
  const ModuleListWidget({
    super.key,
    required this.semName,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return FutureBuilder(
      // Get data from database.
      future: services.getModules(semName.toLowerCase()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Show loading animation while data loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingWave());
        } else if (snapshot.hasError) {
          // Show error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // if there not data for show
          return const Center(child: Text('No data available'));
        }

        // If has data show them in a list view builder
        List<ModuleModel> moduleList = snapshot.data;
        print(semName);
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
      },
    );
  }
}
