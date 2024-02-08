import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
    required this.Title,
    required this.content
  });

  final String Title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                content,textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,

                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
