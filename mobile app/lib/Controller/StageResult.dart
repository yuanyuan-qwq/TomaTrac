import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:workshop2/Controller/API.dart';
import '../ui/Home.dart';
import '../ui/Stage/flowering.dart';
import '../ui/Stage/fruit_formation.dart';
import '../ui/Stage/germination.dart';
import '../ui/Stage/ripening.dart';
import '../ui/Stage/vegetative.dart';

import 'dart:async';

class StageResult extends StatefulWidget {
  final File? image;

  StageResult({File? image}) : image = image;

  @override
  _StageResult createState() => _StageResult();
}

class _StageResult extends State<StageResult> {
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
            (result['state_confidence'] * 100 - 0.01).toStringAsFixed(2);

        setState(() {
          _predictionResult =
              "Stage: ${result['stage']}, \nConfidence: $confidence%";
          _loading = false;
          // Save the result in the class-level variable
          _result = result;
          if (result['stage'] == "no tomato plant detected") {
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
      case 'Flowering Stage':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => flowering()));
        break;

      case 'Fruit Formation Stage':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => fruit_formation()));
        break;

      case 'Germination Stage':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => germination()));
        break;

      case 'Vegetative Stage':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => vegetative()));
        break;

      case 'Ripening Stage':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ripening()));
        break;

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
                              _navigateToClassPage(_result?['stage'] ?? '');
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
