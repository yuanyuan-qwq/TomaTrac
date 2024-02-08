import 'package:flutter/material.dart';

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                              'Hello Friends,',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'don’t forget to keep \nyour plant healthy',
                              style: TextStyle(
                                fontSize: 19,
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
                            'assets/icon/doctor.png',
                            width: 160,
                            height: 140,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    // Container for the main content with a white background and rounded corners
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}
