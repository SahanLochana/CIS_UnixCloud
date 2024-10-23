import 'package:CIS_UnixCloud/core_features/Data/Remote/firebase_services.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/loading_wave.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Components/semester_tile.dart';
import 'package:flutter/material.dart';

class SemesterListWidget extends StatelessWidget {
  const SemesterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return FutureBuilder(
      // Get data from database.
      future: services.getSems(),
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
        List<String> semList = snapshot.data;
        return ListView.builder(
          itemCount: semList.length,
          itemBuilder: (BuildContext context, int index) {
            String eachSemName = semList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SemesterTile(
                semName: eachSemName,
              ),
            );
          },
        );
      },
    );
  }
}
