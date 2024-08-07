import 'package:file_picker/file_picker.dart';

class GetFile {
  Future<FilePickerResult?> getPdfFile() async {
    // pick a file
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
    if (result == null) {
      return null;
    }
    print(result.names.single);
    return result;
  }
}
