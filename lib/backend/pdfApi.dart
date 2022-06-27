import 'dart:io';

import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    Directory generalDownloadDir = Directory(
        '/storage/emulated/0/Download'); //! THIS WORKS for android only !!!!!!

    final file = File('${generalDownloadDir.path}/$name');
    print(file);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      PermissionStatus v = await Permission.storage.request();
      if (v.isGranted) {
        await file.writeAsBytes(bytes);
      }
    } else {
      await file.writeAsBytes(bytes);
    }

    return file;
  }
}
