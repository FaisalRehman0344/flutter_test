import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steps_counter/widgets/card_element.dart';



  Container firstCard(Size size) {
    return Container(
          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          width: size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.cyan),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(100)),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/images/mask_kid.jpg"),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardElement("0", FontAwesomeIcons.coins),
                              SizedBox(height: 5,),
                              cardElement("22", Icons.tag_faces_outlined,
                                  span: "won"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardElement("0", Icons.attach_money,
                                  span: "usd"),
                                  SizedBox(height: 5,),
                              cardElement("9", Icons.face, span: "Loses"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardElement("0", Icons.nordic_walking_outlined),
                              SizedBox(height: 5,),
                              cardElement("345", Icons.people),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }