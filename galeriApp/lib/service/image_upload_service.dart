import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

final ImagePicker picker = ImagePicker();

Future<XFile?> pickImage() async {
  return await picker.pickImage(source: ImageSource.gallery);
}

Future<String?> uploadImage(XFile image) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse("http://10.0.2.2:8086/upload/image"),
  );

  request.files.add(await http.MultipartFile.fromPath('file', image.path));

  final response = await request.send();

  print("UPLOAD STATUS: ${response.statusCode}");
  final body = await response.stream.bytesToString();
  print("UPLOAD BODY: $body");

  if (response.statusCode == 200) {
    return body;
  }

  return null;
}

