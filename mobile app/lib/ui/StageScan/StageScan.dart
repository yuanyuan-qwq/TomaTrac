import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'StageScanPreview.dart';

class StageScan extends StatefulWidget {
  const StageScan({Key? key}) : super(key: key);

  @override
  State<StageScan> createState() => _StageScan();
}

class _StageScan extends State<StageScan> {
  late File image;
  final picker = ImagePicker();

  // Function to get an image from the camera or gallery
  Future getImage(source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        var state = 1;
        if (source == ImageSource.camera) {
          state = 2;
        } else {
          state = 1;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (contex) => StagePreviewScan(
              image: image,
              state: state,
            ),
          ),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // Scaffold provides basic material design structure
      body: SingleChildScrollView(
        // SingleChildScrollView allows scrolling when the content overflows
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity, // Container takes the full width of the screen
          color: Colors.green, // Background color of the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Align children to the start (left) of the column
            children: [

              Container(
                margin: EdgeInsets.only(
                  top: 16,
                  left: 24,
                ),
                // Margin for spacing from the top and left
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align children to the start (left) of the column
                      children: [

                        SizedBox(height: 20,),

                        Text(
                          'Regular care',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'is essential for \nyour plants healthy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      // Align the child (image) to the top right

                      child: Image.asset(
                        'assets/icon/nutritionist1.png',
                        width: 160,
                        height: 140,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: 1000,
                // Container for the main content with a white background and rounded corners
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 30,
                          right: 30,
                          bottom: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Text(
                              'Check your plant now!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => getImage(ImageSource.camera),
                                  child: Image.asset(
                                    'assets/icon/icon_camera.png',
                                    width: 145,
                                    height: 130,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => getImage(ImageSource.gallery),
                                  child: Image.asset(
                                    'assets/icon/icon_gallery.png',
                                    width: 145,
                                    height: 130,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 23,
                        ),
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xFFE5E5E5),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        '\t\t\t How to use?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\t\t\t  -Take a picture of the entire tomato plant',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // use Expanded to allow the image container to take available space
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/icon/stage.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
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
