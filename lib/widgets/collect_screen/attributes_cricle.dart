import 'package:flutter/material.dart';

Column detailCircles(String title, String value, String unit, IconData icon) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.cyan),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.grey.shade600,
        ),
      ),
      Text(
        title,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      Text(
        value,
        style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      Text(
        unit,
        style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      )
    ],
  );
}
