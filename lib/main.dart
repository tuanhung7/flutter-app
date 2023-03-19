import 'dart:convert';
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

  Future<void> _uploadImage() async {
    final url = 'http://ba25-34-74-149-157.ngrok.io/upload-image';
    final response = await http.post(Uri.parse(url), body: {
      'image': base64Encode(_imageBytes!),
    });
    if (response.statusCode == 200) {
      print('Upload success!');
      final decodedResponse = jsonDecode(response.body);
      final ocrText = decodedResponse['ocr_text'];
      print(ocrText);
      setState(() {
        _ocrText = ocrText;
      });
    } else {
      print('Upload failed. Error code: ${response.statusCode}');
    }
    // if (response.statusCode == 200) {
    //   final decodedResponse = jsonDecode(response.body);
    //   final ocrText = decodedResponse['ocr_text'];
    //   print(ocrText);
    //   setState(() {
    //     _ocrText = ocrText;
    //   });
    // } else {
    //   throw Exception('Failed to upload image');
    // }
    // final response = await http.post(Uri.parse(url), body: {
    //   'image': base64Encode(_imageBytes!),
    // });

    // if (response.statusCode == 200) {
    //   final ocrResponse = await http.post(Uri.parse('http://1a0f-34-122-41-92.ngrok.io/ocr'),
    //       body: {'filename': 'image.jpg'});

    //   if (ocrResponse.statusCode == 200) {
    //     final data = jsonDecode(ocrResponse.body);
    //     setState(() {
    //       _ocrText = data['ocr_text'];
    //     });
    //   } else {
    //     print('OCR request failed with status code ${ocrResponse.statusCode}');
    //   }
    // } else {
    //   print('Upload request failed with status code ${response.statusCode}');
    // }

    // final ocrText = response.body;
    // setState(() {
    //   _ocrText = ocrText;
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
                final bytes = await rootBundle.load('output/data(7).jpg');
                setState(() {
                  _imageBytes = bytes.buffer.asUint8List();
                });
              },
              child: Text('Load Image'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _uploadImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              // onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            SizedBox(height: 16.0),
            _ocrText != null ? Text(_ocrText!) : Container(),
          ],
        ),
      ),
    );
  }
}