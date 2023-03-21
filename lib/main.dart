import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/test.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Upload Image Demo',
      home: ImageUploadDemo(),
    );
  }
}

class ImageUploadDemo extends StatefulWidget {
  @override
  _ImageUploadDemoState createState() => _ImageUploadDemoState();
}

class _ImageUploadDemoState extends State<ImageUploadDemo> {
  Uint8List? _imageBytes;
  String? _ocrText;
  File? _image;

  Future<void> _uploadImage() async {
    // final url = 'http://127.0.0.1:5000//upload-image';
    // final response = await http.post(Uri.parse(url), body: {
    //   'image': base64Encode(_imageBytes!),
    // });
    // if (response.statusCode == 200) {
    //   print('Upload success!');
    // } else {
    //   print('Upload failed. Error code: ${response.statusCode}');
    // }
    final text = "Hello, World!";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
        // Tạo request và gửi ảnh lên server
    // var request = http.MultipartRequest('POST', Uri.parse('http://<your_server_address>/ocr'));
    // request.files.add(await http.MultipartFile.fromPath('image', _image.path));
    // var response = await request.send();

    // // Đọc kết quả OCR trả về
    // var responseBody = await response.stream.bytesToString();
    // var responseJson = json.decode(responseBody);
    // setState(() {
      
    //   _ocrText = responseJson['result'];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null ? Image.memory(_imageBytes!) : Placeholder(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final bytes = await rootBundle.load('output/data(6).jpg');
                setState(() {
                  _imageBytes = bytes.buffer.asUint8List();
                });
              },
              child: Text('Load Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              // onPressed: () {
              //   _uploadImage();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => MyHomePage()),
              //   );
              // },
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            // SizedBox(height: 16.0),
            // _ocrText != null ? Text(_ocrText!) : Container(),
          ],
        ),
      ),
    );
  }
}