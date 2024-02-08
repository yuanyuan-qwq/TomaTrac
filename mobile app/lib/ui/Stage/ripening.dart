import 'package:flutter/material.dart';

import '../../models/category_grid.dart';
import '../../models/Overview.dart';
import '../Home.dart';

class ripening extends StatelessWidget {
  const ripening({Key? key});

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
                    image: AssetImage('assets/stage/Ripening.jpg'),
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
                      "Ripening Stage",
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
                          detail: 'Stop fertilizing',
                          color: Colors.purple.shade500,
                          iconData: Icons.backpack_rounded, // Change the icon here based on your function call
                        ),
                        CategoryGrid(
                          category: 'Water',
                          detail: '1-1.5 liters',
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
                          detail: 'Remaining shading leaves',
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
                            content: 'Reduce or stop fertilizing at this stage to prevent negatively impacting flavor.'
                        ),
                        Overview(
                          Title: 'Sunlight',
                          content: 'Ensure the plant still gets adequate sunlight for the final ripening process.',

                        ),
                        Overview(
                          Title: 'Soil',
                          content: 'Continue to monitor soil moisture, ensuring it\'s consistent but not waterlogged.',

                        ),

                        Overview(
                          Title: 'Water',
                          content: 'Remove any remaining leaves that might shade ripening fruits to encourage full sun exposure.',

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
