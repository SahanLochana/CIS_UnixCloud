import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Widgets/module_tile_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StatusProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            "Modules",
            style: TextStyle(fontFamily: "dmsans", color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ModuleListWidget(
            semName: value.selectedSem,
          ),
        ),
      );
    });
  }
}
