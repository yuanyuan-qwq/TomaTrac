import 'package:flutter/material.dart';

import '../../models/Overview.dart';
import '../Home.dart';

class bacterial_spot extends StatelessWidget {
  const bacterial_spot({Key? key}) : super(key: key);

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
              color: Colors.black,
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
                "Tomato Bacterial Spot",
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
                        'assets/disease/Bacterial Spot.jpg',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: size.height * .26),
                    child: const Text(
                      'Tomato Bacterial Spot',
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
                      content: '- Small, round, water-soaked spots\n- Gradually turn dark-brown or black\n- Surrounded by a yellow halo'
                  ),
                  Overview(
                    Title: 'Possible causes',
                    content: "Four types of Xanthomonas (Species of bacteria). These pathogens can be transmitted by seeds and transplants. These bacteria can be introduced into gardens by contaminated seed and transplants which or may not show symptoms.",

                  ),
                  Overview(
                    Title: 'Possible solution',
                    content: "- Use disease-resistant tomato cultivars or clean, disease-free seeds\n"
                        "- Cover soil with mulch, avoid overcrowding, and avoid overhead watering\n"
                        "- Use copper fungicide when symptoms appear\n"
                        "- Remove and dispose of infected crop residue",
                  ),


                ],
              ),

              SizedBox(height: 30,),

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

