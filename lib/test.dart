import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hiii',
      home: TestGET(),
    );
  }
}

class TestGET extends StatefulWidget {
  @override
  _TestGETState createState() => _TestGETState();
}

class _TestGETState extends State<TestGET> {
  String _ocrText = '';
  Uint8List? _imageBytes;
  
  Future<void> getData() async {
    // final url = 'http://127.0.0.1:5000//data';
    // final response = await http.get(Uri.parse(url), 
    //   // body: { }, 
    //   headers: {'Access-Control-Allow-Origin': '*'});
    // if (response.statusCode == 200) {
    //   // print('Upload success!');
    //   // final decodedResponse = jsonDecode(response.body);
    //   // final ocrText = decodedResponse['name'];
    //   // print(ocrText);
    //   // setState(() {
    //   //   _ocrText = ocrText;
    //   // });

    //   setState(() {
    //     _ocrText = response.body;
    //   });
      
    // } else {
    //   print('Upload failed. Error code: ${response.statusCode}');
    // }
    // var url = 'http://1b96-34-74-149-157.ngrok.io/data';
    // var response = await http.get(Uri.parse(url));
    // if (response.statusCode == 200) {
    //   setState(() {
    //     jsonData = response.body;
    //   });
    // } else {
    //   throw Exception('Failed to load data');
    // }
    final bytes = await rootBundle.load('output/data(6).jpg');
    _imageBytes = bytes.buffer.asUint8List();
    final url = 'http://127.0.0.1:5000//upload-image';
    
    final response = await http.post(Uri.parse(url), 
    
    body: {
      'image': base64Encode(_imageBytes!),
    });
    

    if (response.statusCode == 200) {
      print('Upload success!');
      setState(() {
        // _ocrText = response.body;
        Map<String, dynamic> data = json.decode(response.body);
        _ocrText = data['result'];
      });
    } else {
      print('Upload failed. Error code: ${response.statusCode}');
    }
  }
  @override
  void initState() {
    super.initState();

    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get JSON Data from Flask Server'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            _ocrText.isEmpty
                // ? Text('No Data Yet')
                ? CircularProgressIndicator()
                : Expanded(
                    child: Text(_ocrText),
                  ),
          ],
        ),
      ),
    );
  }
}