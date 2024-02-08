import 'package:flutter/material.dart';

import '../../models/category_grid.dart';
import '../../models/Overview.dart';
import '../Home.dart';

class fruit_formation extends StatelessWidget {
  const fruit_formation({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],

      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),  // Adjust the values as needed for the desired curve
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/stage/Fruit Formation.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                height: 250.0,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fruit Formation Stage",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    SizedBox(height: 5,),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      //crossAxisSpacing: 5,
                      //mainAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      children: [
                        CategoryGrid(
                          category: 'Fertilizer',
                          detail: 'Every month',
                          color: Colors.purple.shade500,
                          iconData: Icons.backpack_rounded, // Change the icon here based on your function call
                        ),
                        CategoryGrid(
                          category: 'Water',
                          detail: '1.5-2 liters',
                          color: Colors.blue.shade300,
                          iconData: Icons.water_drop, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Sunlight',
                          detail: '6-8 hours',
                          color: Colors.orange.shade500,
                          iconData: Icons.sunny, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Pruning',
                          detail: 'Remove yellow leaf',
                          color: Colors.red.shade500,
                          iconData: Icons.cut, // Another icon based on your logic
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                            Title: 'Fertilizer',
                            content: 'Stick with the phosphorus-rich fertilizer to support fruit growth.'
                        ),
                        Overview(
                          Title: 'Sunlight',
                          content: 'Maintain consistent sunlight exposure to help with fruit development.',

                        ),
                        Overview(
                          Title: 'Soil',
                          content: 'Mulch around the plant to maintain soil moisture and prevent weed growth.',

                        ),

                        Overview(
                          Title: 'Water',
                          content: 'Water deeply and regularly, especially during hot weather, ensuring consistent moisture.',

                        ),

                        Overview(
                          Title: 'Pruning',
                          content: 'Remove any yellowing or diseased leaves to divert energy to the fruits.',
                        ),

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
            ],
          ),
        ),
      ),
    );
  }
}
