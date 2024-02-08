import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2/ui/advice/Early_blight.dart';
import 'package:workshop2/ui/advice/Late_blight.dart';
import 'package:workshop2/ui/advice/Leaf_Mold.dart';
import 'package:workshop2/ui/advice/Tar_get_Spot.dart';
import 'package:workshop2/ui/advice/Twospotted_spider_mites.dart';
import 'package:workshop2/ui/advice/Yellow_Leaf_Curl_Virus.dart';
import 'package:workshop2/ui/advice/bacterial_spot.dart';
import 'package:workshop2/ui/advice/healthy.dart';
import 'package:workshop2/ui/advice/mosaic_virus.dart';

import '../ui/Home.dart';
import '../ui/advice/Septoria_leaf_spot.dart';

import 'dart:async';

import 'API.dart';

class ResultPage extends StatefulWidget {
  final File? image;

  ResultPage({File? image}) : image = image;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _predictionResult = "";
  bool _loading = true;
  Uint8List? _uploadedImage; // Define _uploadedImage here

  @override
  void initState() {
    super.initState();
    // Perform the prediction when the page is first loaded
    _predictImage();
  }

  Future<void> uploadImageToServer(File imageFile) async {
    EasyLoading.show(status: 'loading...', dismissOnTap: true);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$FastapiKey/detect/'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ),
    );

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        setState(() {
          _uploadedImage = responseData;
        });
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _predictImage() async {
    if (widget.image == null) {
      setState(() {
        _predictionResult = "Error: Image file is null.";
        _loading = false;
      });
      return;
    }

    final uri = Uri.parse("http://$FastapiKey/predict");
    final request = http.MultipartRequest("POST", uri)
      ..files
          .add(await http.MultipartFile.fromPath("file", widget.image!.path));
    uploadImageToServer(widget.image!);

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();
        final result = jsonDecode(body);

        String confidence =
            (result['confidence'] * 100 - 0.01).toStringAsFixed(2);

        setState(() {
          _predictionResult =
              "Class: ${result['class']}, \nConfidence: $confidence%";
          _loading = false;
          // Save the result in the class-level variable
          _result = result;
          if (result['class'] == "No Leaf Detected" ||
              result['class'] == "Not a Tomato Leaf") {
            _result = null;
          }
        });
      } else {
        setState(() {
          _predictionResult = "Error: ${response.reasonPhrase}";
          _loading = false;
          // Set _result to null in case of an error
          _result = null;
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = "Error: $e";
        _loading = false;
        // Set _result to null in case of an error
        _result = null;
      });
    }
    EasyLoading.dismiss();
  }

  Map<String, dynamic>? _result;

  void _navigateToClassPage(String predictedClass) {
    switch (predictedClass) {
      case 'Tomato Bacterial spot':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bacterial_spot()));
        break;

      case 'Tomato Early blight':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Early_blight()));
        break;

      case 'Tomato Late blight':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Late_blight()));
        break;

      case 'Tomato Leaf Mold':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Leaf_Mold()));
        break;

      case 'Tomato Septoria leaf_spot':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Septoria_leaf_spot()));
        break;

      case 'Tomato Twospotted Spider Mites':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Twospotted_spider_mites()));
        break;

      case 'Tomato Target Spot':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tar_get_Spot()));
        break;

      case 'Tomato Yellow Leaf Curl Virus':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Yellow_Leaf_Curl_Virus()));
        break;

      case 'Tomato mosaic virus':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mosaic_virus()));
        break;

      case 'Healthy':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => healthy()));
        break;

      // Add more cases for other disease classes as needed
      default:
        // Handle unknown class or navigate to a default page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Result'),
        backgroundColor: Colors.green,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: 600,
                      child: _uploadedImage == null
                          ? Text('Loading Image...')
                          : Image.memory(_uploadedImage!, fit: BoxFit.cover),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _predictionResult,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _result != null
                          ? () {
                              _navigateToClassPage(_result?['class'] ?? '');
                            }
                          : null,
                      child: Text("View Details"),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            icon: Icon(
                              Icons.home,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
