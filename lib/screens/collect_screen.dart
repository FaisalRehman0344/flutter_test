import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steps_counter/components/first_card.dart';
import 'package:steps_counter/widgets/card_element.dart';

class CollectScreen extends StatefulWidget {
  const CollectScreen({Key? key}) : super(key: key);

  @override
  State<CollectScreen> createState() => _CollectScreenState();
}

class _CollectScreenState extends State<CollectScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            firstCard(size),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                color: Colors.grey.shade800
              ),
              child: Text("0/1000",style: TextStyle(color: Colors.white,fontSize: 10),),
            )
          ],
        ),
      ),
    );
  }
}
