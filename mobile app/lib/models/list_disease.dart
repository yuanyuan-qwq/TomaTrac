import 'package:flutter/material.dart';
import 'package:workshop2/ui/advice/Late_blight.dart';
import '../ui/advice/Early_blight.dart';
import '../ui/advice/Leaf_Mold.dart';
import '../ui/advice/Septoria_leaf_spot.dart';
import '../ui/advice/Tar_get_Spot.dart';
import '../ui/advice/Twospotted_spider_mites.dart';
import '../ui/advice/Yellow_Leaf_Curl_Virus.dart';
import '../ui/advice/bacterial_spot.dart';
import '../ui/advice/healthy.dart';
import '../ui/advice/mosaic_virus.dart';

class Items {
  final String title;
  final String img;

  Items({required this.title, required this.img});
}

class list_disease extends StatelessWidget {
  final List<Items> items = [
    Items(title: "Bacterial Spot", img: "assets/disease/Bacterial Spot.jpg"),
    Items(title: "Early Blight", img: "assets/disease/Early Blight.jpeg"),
    Items(title: "Late Blight", img: "assets/disease/Late Blight.jpg"),
    Items(title: "Healthy", img: "assets/disease/health.jpg"),
    Items(title: "Leaf Mold", img: "assets/disease/Leaf Mold.jpg"),
    Items(
        title: "Septoria Leaf Spot",
        img: "assets/disease/Septoria Leaf Spot.jpg"),
    Items(
        title: "Twospotted Spider Mites",
        img: "assets/disease/Two-Spotted Spider Mites.jpg"),
    Items(title: "Tar-get Spot", img: "assets/disease/Target Spot.jpg"),
    Items(title: "Mosaic Virus", img: "assets/disease/Mosaic Virus.jpg"),
    Items(
        title: "Yellow Leaf Curl Virus",
        img: "assets/disease/Yellow Leaf Curl Virus.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              // Perform navigation based on the item title
              switch (item.title) {
                case 'Bacterial Spot':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => bacterial_spot()),
                  );
                  break;
                case 'Early Blight':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Early_blight()),
                  );
                  break;
                case 'Healthy':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => healthy()),
                  );
                  break;
                case 'Late Blight':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Late_blight()),
                  );
                  break;
                case 'Leaf Mold':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Leaf_Mold()),
                  );
                  break;
                case 'Septoria Leaf Spot':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Septoria_leaf_spot()),
                  );
                  break;
                case 'Twospotted Spider Mites':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Twospotted_spider_mites()),
                  );
                  break;
                case 'Tar-get Spot':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tar_get_Spot()),
                  );
                  break;
                case 'Mosaic Virus':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mosaic_virus()),
                  );
                  break;
                case 'Yellow Leaf Curl Virus':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Yellow_Leaf_Curl_Virus()),
                  );
                  break;
//++++++++++++++++++++++++
                default:
                  break;
              }
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(item.img), // Use the item's image
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title, // Use the item's title
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
