import 'package:CIS_UnixCloud/core_features/presantation/Widgets/module_tile_list_widget.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Modules",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: ModuleListWidget(),
      ),
    );
  }
}
