import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/StageResult.dart';


class StagePreviewScan extends StatefulWidget {
  StagePreviewScan({
    Key? key,
    required this.image,
    required this.state,
  }) : super(key: key);

  File? image;
  final int state;

  @override
  State<StagePreviewScan> createState() => _StagePreviewScan();
}

class _StagePreviewScan extends State<StagePreviewScan> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.white, // Placeholder color
          toolbarHeight: 60,
          centerTitle: true,
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 23),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.green, // Placeholder color
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                'Preview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Placeholder color
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 427,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: 58,
                ),
                child: Image.file(
                  widget.image!,
                  fit: BoxFit.cover,
                ),
              ),
              // Elevated button for changing the picture
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(
                  horizontal: 96,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    primary: Colors.green, // Placeholder color
                  ),
                  onPressed: () {
                    // File picker for the gallery or camera
                    ImagePicker()
                        .pickImage(
                      source: widget.state == 1
                          ? ImageSource.gallery
                          : ImageSource.camera,
                    )
                        .then((value) {
                      if (value != null) {
                        // Override the image
                        setState(() {
                          widget.image = File(value.path);
                        });
                      }
                    });
                  },
                  child: Text(
                    'Change Picture',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Placeholder color
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              // Elevated button for scanning
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    primary: Colors.amber, // Placeholder color
                  ),
                  onPressed: () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StageResult(
                          image: widget.image,
                        ),
                      ),
                    );

                  },
                  child: Text(
                    'Scan Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Placeholder color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
