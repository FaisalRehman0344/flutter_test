import 'package:flutter/material.dart';

Widget actionButton({required Icon icon, required String count}) {
  return Stack(
    children: [
      IconButton(onPressed: () {}, icon: icon),
      Positioned(
        left: 25,
        top: 10,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(100)),
          child: Center(
              child: Text(count,
                  style: const TextStyle(color: Colors.white, fontSize: 8))),
        ),
      ),
    ],
  );
}
