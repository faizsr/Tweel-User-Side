import 'dart:convert';
import 'dart:io';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:http/http.dart' as http;

class CloudRepo {
  static Future<List<String>> uploadImage(
      List<AssetEntity> selectedAssets) async {
    File? image;
    List<String> imagePath = [];
    final url = Uri.parse('https://api.cloudinary.com/v1_1/domckmnha/upload');
    for (int i = 0; i < selectedAssets.length; i++) {
      image = await selectedAssets[i].file;
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'wbi7jenn'
        ..files.add(await http.MultipartFile.fromPath('file', image!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        imagePath.add(url);
      }
    }
    return imagePath;
  }
}
