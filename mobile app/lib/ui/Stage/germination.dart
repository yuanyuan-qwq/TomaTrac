import 'package:flutter/material.dart';

import '../../models/category_grid.dart';
import '../../models/Overview.dart';
import '../Home.dart';

class germination extends StatelessWidget {
  const germination({Key? key});

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
                    image: AssetImage('assets/stage/germination.jpg'),
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
                      "Germination Stage",
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
                          detail: 'No need',
                          color: Colors.purple.shade500,
                          iconData: Icons.backpack_rounded, // Change the icon here based on your function call
                        ),
                        CategoryGrid(
                          category: 'Water',
                          detail: 'Lightly mist',
                          color: Colors.blue.shade300,
                          iconData: Icons.water_drop, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Sunlight',
                          detail: '4-6 hours',
                          color: Colors.orange.shade500,
                          iconData: Icons.sunny, // Another icon based on your logic
                        ),
                        CategoryGrid(
                          category: 'Pruning',
                          detail: 'No need',
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
                            content: 'No fertilizer is needed at this stage as the seed contains enough nutrients to sprout.'
                        ),
                        Overview(
                          Title: 'Sunlight',
                          content: 'Place the seeds in a warm, sunny spot to encourage germination.',

                        ),
                        Overview(
                          Title: 'Soil',
                          content: 'Use a well-draining soil mix to prevent waterlogging that can rot seeds.',

                        ),

                        Overview(
                          Title: 'Water',
                          content: 'Keep the soil consistently moist, not soaked, to aid germination.',

                        ),

                        Overview(
                          Title: 'Pruning',
                          content: 'Not necessary during germination.',
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
                    ),
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
