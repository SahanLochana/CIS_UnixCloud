import 'package:flutter/material.dart';
import 'package:student_manegment_app/features/download_file/data/remote/file_download.dart';

class DownloadTile extends StatefulWidget {
  const DownloadTile({super.key});

  @override
  State<DownloadTile> createState() => _DownloadTileState();
}

class _DownloadTileState extends State<DownloadTile> {
  @override
  Widget build(BuildContext context) {
    // progress
    double progress = 0.0;

    // instance of [FileDownload] class
    FileDownload downloadClass = FileDownload();

    // function for update progress
    void progressUpdater(double currentProgress) {
      setState(() {
        progress = progress;
      });
    }

// TODO intigrate with provider
    // pouse
    void _taskPouse() {}

    // resume
    void _taskResume() {}

    // cancel
    void _taskCancel() {}

    // start download
    void _taskStart() {
      downloadClass.downloadFile(
        "",
        "",
        (progress) => progressUpdater(progress),
      ); //TODO replace with real path and name
    }

    return const Scaffold();
  }
}
