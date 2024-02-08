import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/chat_page.dart';
import '../ui/Weather/ui/home_page.dart';
import '../ui/Scan.dart';
import '../ui/Library.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Items {
  String title;
  String subtitle;
  String img;
  Items({required this.title, required this.subtitle, required this.img});
}

class GridMenu extends StatelessWidget {
  Items item1 = new Items(
      title: "Scan",
      subtitle: "",
      img: "assets/icon/icon7.png");

  Items item2 = new Items(
      title: "Library",
      subtitle: "",
      img: "assets/icon/library.png");

  Items item3 = new Items(
      title: "Weather",
      subtitle: "",
      img: "assets/icon/weather.png");

  Items item4 = new Items(
      title: "ChatBot",
      subtitle: "",
      img: "assets/icon/bot.png");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Items> myList = [item1, item2, item3, item4];

    return Flexible(
      child: GridView.count(
        childAspectRatio: 0.0016*size.width,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2, //Adjust Grid
        crossAxisSpacing: 35,
        mainAxisSpacing: 35,
        children: myList.map((data) {
          return GestureDetector(
            onTap: () {
              switch (data.title) {
                case 'Scan':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Scan()),
                  );
                  break;
                case 'Library':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Library()),
                  );
                  break;
                case 'Weather':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  break;
                case 'ChatBot':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                  break;
                default:
                  break;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white60, //grid box color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  //adjust shadow here
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    data.img,
                    width: 90,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ).animate()
                .fade(duration: 600.ms)
                .scale(delay: 100.ms),
          );
        }).toList(),
      ),
    );
  }
}
