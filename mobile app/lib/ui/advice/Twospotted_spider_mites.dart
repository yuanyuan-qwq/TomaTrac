import 'package:flutter/material.dart';
import 'package:workshop2/models/Overview.dart';

import '../Home.dart';

class Twospotted_spider_mites extends StatelessWidget {
  const Twospotted_spider_mites({Key? key}) : super(key: key);

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
              SizedBox(
                height: 10,
              ),
              Text(
                "Tomato Twospotted Spider Mites",
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: size.height * .30,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/disease/Two-Spotted Spider Mites.jpg',
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
                      'Tomato Twospotted Spider Mites',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Overview",
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
                    content: "- Yellow or white stippling on leaves\n"
                        "- Yellow blotching, dirty appearance on leaf undersides",
                  ),
                  Overview(
                    Title: 'Possible causes',
                    content:
                        "Spider mites can be seen on leaf undersides with the naked eye or using a hand lens. It sucks chlorophyll from leaf tissues, resulting in yellow discoloration.",
                  ),
                  Overview(
                    Title: 'Possible solution',
                    content: "- Hose off plants to cool and clean\n"
                        "- Use horticultural oil or insecticidal soap\n"
                        "- Use horticultural oil or insecticidal soap",
                  ),
                ],
              ),

              SizedBox(
                height: 30,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
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
