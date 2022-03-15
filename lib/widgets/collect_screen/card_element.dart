import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget cardElement(String title, IconData icon, {String? span}) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 3),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.cyan),
            borderRadius: BorderRadius.circular(100),
          ),
          child: FaIcon(
            icon,
            size: 15,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: title,
                  style: TextStyle(
                      fontSize: int.parse(title) > 100 ? 10 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600)),
              TextSpan(
                  text: span,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600))
            ],
          ),
        )
      ],
    ),
  );
}
