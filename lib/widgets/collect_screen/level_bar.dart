import 'package:flutter/material.dart';

Widget levelBar(Size size, int level, double progress) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.cyan,
    ),
    width: size.width,
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "LEV. $level",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: size.width * .5,
          height: 5,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
          ),
        ),
        Container(
          child: Row(
            children: [
              Text(
                "EARN 50",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              CircleAvatar(
                  radius: 6,
                  backgroundImage: AssetImage("assets/images/coin.png"))
            ],
          ),
        ),
      ],
    ),
  );
}
