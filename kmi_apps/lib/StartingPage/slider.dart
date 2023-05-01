import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;

  const SliderPage({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 52,
                  ),
                  Text(
                    title!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    description!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
