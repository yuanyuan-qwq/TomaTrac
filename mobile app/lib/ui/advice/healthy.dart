import 'package:flutter/material.dart';
import 'package:workshop2/models/Overview.dart';

import '../Home.dart';

class healthy extends StatelessWidget {
  const healthy({Key? key}) : super(key: key);

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
                "Tomato status:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Healthy",
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
                        'assets/disease/health.jpg',
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
                      'Healthy',
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
                    content: "- Vibrant green leaves\n"
                        "- Uniform growth and size\n"
                        "- No discoloration or spots on leaves\n"
                        "- Firm and blemish-free tomatoes",
                  ),
                  Overview(
                    Title: 'Possible causes',
                    content: "- Adequate sunlight exposure\n"
                        "- Proper watering practices\n"
                        "- Well-draining and nutrient-rich soil\n"
                        "- Absence of pests and diseases",
                  ),
                  Overview(
                    Title: 'Possible solution',
                    content:
                        "- Ensure tomatoes plant receive at least 6-8 hours of sunlight daily\n"
                        "- Water consistently, keeping the soil evenly moist but not waterlogged\n"
                        "- Use quality soil with organic matter and provide balanced fertilizer\n"
                        "- Monitor for pests and diseases, take preventive measures such as companion planting",
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
