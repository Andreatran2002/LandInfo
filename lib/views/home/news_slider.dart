import 'package:flutter/material.dart';

class SliderForNews extends StatelessWidget {
  const SliderForNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 200,
            height: 170,
            color: Colors.black,
            // decoration: BoxDecoration(
            //     // color: Colors.black,
            //     ),
          ),
          SizedBox(width: 20),
          Container(
            width: 200,
            height: 170,
            color: Colors.black,
            // decoration: BoxDecoration(
            //     // color: Colors.black,
            //     ),
          ),
          SizedBox(width: 20),
          Container(
            width: 200,
            height: 170,
            color: Colors.black,
            // decoration: BoxDecoration(
            //     // color: Colors.black,
            //     ),
          ),
        ],
      ),
    );
  }
}
