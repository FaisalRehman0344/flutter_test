import 'package:flutter/material.dart';


class ActionButton extends StatelessWidget {
  final Icon icon;
  final String count;
  const ActionButton({
    Key? key, required this.icon, required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: icon
        ),
        Positioned(
          left: 22,
          top: 8,
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
}
