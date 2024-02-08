import 'package:flutter/material.dart';
import 'package:workshop2/models/Overview.dart';

import '../Home.dart';

class mosaic_virus extends StatelessWidget {
  const mosaic_virus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            )),
        title: Text("Tomato Plant Disease Advice", style: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Disease name:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),

              SizedBox(height: 10,),

              Text(
                "Tomato Mosaic Virus",
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),

              SizedBox(height: 20,),
              Container(
                height: size.height * .30,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/disease/Mosaic Virus.jpg',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: size.height * .26),
                    child: const Text(
                      'Tomato Mosaic Virus',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text("Overview",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView(
                primary: false,
                shrinkWrap: true,
                children: const [
                  Overview(
                      Title: 'Symptoms',
                      content:  "- Twisting, curling, distorted leaves\n"
                    "- Leaves smaller than normal, rough, and crinkled",
                  ),
                  Overview(
                    Title: 'Possible causes',
                    content: "Transmitted plant to plant by many species of aphids which only retain the ability to transmit these viruses for very short periods of time. Thus, spread is often very rapid and localized. ",

                  ),
                  Overview(
                    Title: 'Possible solution',
                    content: "- Remove and discard infected plants\n"
                    "- Control weeds and aphid pests\n"
                    "- Grow or purchase virus-resistant transplants",
                  ),
              SizedBox(height: 30,),
                ],
              ),


              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

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
                            MaterialPageRoute(builder: (context) => Home())
                        );
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

