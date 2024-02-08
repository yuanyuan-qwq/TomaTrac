import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/GridMenu.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sky1.png'),
            fit:
                BoxFit.cover, // Adjusts the image to cover the entire container
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/icon/TomaTrac.png',
                      width: 290,
                      height: 130,
                      fit: BoxFit.fill, // or other BoxFit values
                    ).animate()
                .fade(duration: 500.ms)
                .scale(delay: 100.ms),
                    Stack(
                      children: <Widget>[
                        Text(
                          //text for outline
                          'Welcome',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ).animate()
                        .fade(duration: 500.ms)
                        .scale(delay: 200.ms),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GridMenu(),
          ],
        ),
      ),
    );
  }
}
