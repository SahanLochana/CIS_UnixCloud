import 'package:CIS_UnixCloud/core_features/Data/Models/doc_modal.dart';
import 'package:CIS_UnixCloud/core_features/Data/Remote/firebase_services.dart';
import 'package:CIS_UnixCloud/core_features/Provider/current_status_provider.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/item_tile.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/records_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListWidget extends StatelessWidget {
  final String moduleId;
  const ItemListWidget({
    super.key,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return Consumer<StatusProvider>(
      builder: (context, value, child) {
        String category = value.selectedCategory;
        return FutureBuilder(
            future: services.getdocs(moduleId, category),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // show loading animation while data load
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingWave());
                // when got error
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
                // if ther no data
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              // if has data
              List<DocDataModal> itemList = snapshot.data;
              return ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  DocDataModal eachDocDataModal = itemList[index];
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: category != "Records"
                          ? ItemTile(
                              docDataModal: eachDocDataModal,
                              moduleId: moduleId,
                            )
                          : RecordTile(docDataModal: eachDocDataModal));
                },
              );
            });
      },
    );
  }
}
