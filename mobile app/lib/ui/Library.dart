import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:workshop2/models/list_disease.dart';
import '../models/list_stage.dart';


class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library', style: TextStyle(color: Colors.black, letterSpacing: 1.5)),
          centerTitle: true,
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200.0), // here the desired height
            child: Column(
              children: [
                Container(  //upper part
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 24, bottom: 0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(height: 20),
                            Text(
                              'Knowledge is Power!',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Text(
                              'Take care your \ntomato plant now',
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/icon/nutritionist2.png',
                            width: 165,
                            height: 145,
                          ),
                        ),
                      ],
                    ).animate()
                        .fade(duration: 800.ms),
                  ),
                ),
                TabBar(
                  indicator: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightGreen.withOpacity(0.5), // Customize shadow color and opacity
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(5, 3), // Adjust the offset if needed
                      ),
                    ],
                  ),
                  tabs: [
                    Tab(icon: Icon(Icons.local_library_outlined), text: 'Type of Disease'),
                    Tab(icon: Icon(Icons.local_florist), text: 'Tomato Plant Stage'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(  //bottom part
                    width: double.infinity,
                    child: Column(
                      children: [
                        list_disease()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(  //bottom part
                    width: double.infinity,
                    child: Column(
                      children: [
                        list_stage()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate()
            .fade(duration: 500.ms).move(delay: 300.ms, duration: 600.ms),
      ),
    );
  }
}
