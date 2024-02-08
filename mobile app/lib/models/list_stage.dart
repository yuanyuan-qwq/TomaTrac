import 'package:flutter/material.dart';
import '../ui/Stage/flowering.dart';
import '../ui/Stage/fruit_formation.dart';
import '../ui/Stage/germination.dart';
import '../ui/Stage/ripening.dart';
import '../ui/Stage/vegetative.dart';


class Items {
  final String title;
  final String img;

  Items({required this.title, required this.img});
}

class list_stage extends StatelessWidget {
  final List<Items> items = [
    Items(title: "Germination Stage", img: "assets/stage/germination.jpg"),
    Items(title: "Vegetative Stage", img: "assets/stage/Vegetative.jpg"),
    Items(title: "Flowering Stage", img: "assets/stage/Flowering.jpg"),
    Items(title: "Fruit Formation Stage", img: "assets/stage/Fruit Formation.jpg"),
    Items(title: "Ripening Stage", img: "assets/stage/Ripening.jpg"),
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
                case 'Germination Stage':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => germination()),
                  );
                  break;
                case 'Vegetative Stage':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => vegetative()),
                  );
                  break;
                case 'Flowering Stage':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => flowering()),
                  );
                  break;
                case 'Fruit Formation Stage':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => fruit_formation()),
                  );
                  break;
                case 'Ripening Stage':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ripening()),
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
