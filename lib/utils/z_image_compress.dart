import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart';

class ZImageCompress {
  static Future<File> getCompressImageFile(File file) async {
    var uuid = new Uuid();
    var dir = await path_provider.getTemporaryDirectory();
    var targetPath = dir.absolute.path + uuid.v1() + '.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 70, minWidth: 600, minHeight: 600, rotate: 0);

    result = result ?? file;

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }
}
