import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FileServices {
  static Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );
    if (result != null) {
      final File file = File(result.files.single.path!);
      return file;
    }
    return null;
  }

  static Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      return image;
    }
    return null;
  }

  static Future<List<XFile>> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    return images;
  }

  static Future<XFile?> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (video != null) {
      return video;
    }

    return null;
  }

  static MediaType getFileMediaType({
    required dynamic pickedImage,
  }) {
    final fileExtension = extension(pickedImage.path).substring(1);
    return MediaType('image/$fileExtension', fileExtension);
  }
}
