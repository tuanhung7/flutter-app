import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyHomePage());
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String jsonData = '';

  Future<void> getData() async {
    var url = 'http://1b96-34-74-149-157.ngrok.io/get-data';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        jsonData = response.body;
      });
    } else {
      throw Exception('Failed to load data');
    }
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
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text('Get JSON Data'),
            ),
            SizedBox(height: 20),
            jsonData.isEmpty
                ? Text('No Data Yet')
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        jsonData,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}