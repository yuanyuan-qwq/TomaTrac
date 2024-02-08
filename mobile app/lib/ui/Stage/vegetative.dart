import 'package:flutter/material.dart';

import '../../models/category_grid.dart';
import '../../models/Overview.dart';
import '../Home.dart';

class vegetative extends StatelessWidget {
  const vegetative({Key? key});

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
                    image: AssetImage('assets/stage/Vegetative.jpg'),
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
                      "Vegetative Stage",
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
                          detail: 'Every 2 weeks',
                          color: Colors.purple.shade500,
                          iconData: Icons.backpack_rounded, // Change the icon here based on your function call
                        ),
                        CategoryGrid(
                          category: 'Water',
                          detail: '1 liter',
                          color: Colors.blue.shade300,
                          iconData: Icons.water_drop, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Sunlight',
                          detail: '6-8 hours ',
                          color: Colors.orange.shade500,
                          iconData: Icons.sunny, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Pruning',
                          detail: 'Remove lower leaves',
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
                            content: 'Start with a balanced fertilizer once the seedlings have a few sets of true leaves.'
                        ),
                        Overview(
                          Title: 'Sunlight',
                          content: 'Provide at least 6-8 hours of direct sunlight daily for healthy growth.',

                        ),
                        Overview(
                          Title: 'Soil',
                          content: 'Ensure well-draining soil with good aeration to support root development.',

                        ),

                        Overview(
                          Title: 'Water',
                          content: 'Water deeply and consistently, keeping the soil evenly moist.',

                        ),

                        Overview(
                          Title: 'Pruning',
                          content: 'Remove lower leaves to promote airflow and discourage disease.',
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
