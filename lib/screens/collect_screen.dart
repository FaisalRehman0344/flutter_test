import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_counter/components/first_card.dart';
import 'package:steps_counter/widgets/collect_screen/attributes_cricle.dart';
import 'package:steps_counter/widgets/collect_screen/level_bar.dart';
import 'package:steps_counter/models/Step.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CollectScreen extends StatefulWidget {
  const CollectScreen({Key? key}) : super(key: key);

  @override
  State<CollectScreen> createState() => _CollectScreenState();
}

class _CollectScreenState extends State<CollectScreen> {
  int _level = 1;
  double _progress = 0.0;
  int _steps = 0;
  Color dayButtonColor = Colors.grey.shade700;
  Color weekButtonColor = Colors.cyan;
  Color monthButtonColor = Colors.cyan;
  late Stream<StepCount> _stepCountStream;
  List<DailyStep> _statsData = [];
  var seriesList;

  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateFormat dayFormatter = DateFormat('EEEE');
  DateFormat monthFormatter = DateFormat('MMMM');

  void onStepCount(StepCount event) {
    int steps = event.steps;
    saveSteps(steps);
  }

  void statsChange(String title) {
    onStateChange(title);
    setState(() {
      if (title == "Day") {
        dayButtonColor = Colors.grey.shade700;
        monthButtonColor = Colors.cyan;
        weekButtonColor = Colors.cyan;
      } else if (title == "Week") {
        weekButtonColor = Colors.grey.shade700;
        dayButtonColor = Colors.cyan;
        monthButtonColor = Colors.cyan;
      } else if (title == "Month") {
        monthButtonColor = Colors.grey.shade700;
        dayButtonColor = Colors.cyan;
        weekButtonColor = Colors.cyan;
      }
    });
  }

  void saveSteps(int steps) {
    String month = monthFormatter.format(now);
    String day = dayFormatter.format(now);
    String date = formatter.format(now);
    DailyStep step = DailyStep(
        steps: steps,
        date: date,
        day: day,
        month: month,
        timestamp: DateTime.now().hour.toString() +
            ":" +
            DateTime.now().minute.toString());

    CollectionReference stepsCollection =
        FirebaseFirestore.instance.collection("Steps");
    stepsCollection.doc(date).set(step.toJson(), SetOptions(merge: true));
    setState(() {
      _steps = steps;
    });
  }

  Future<void> initPlatformState() async {
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError((e) => print(e));
  }

  void onStateChange(String state) {
    CollectionReference<Map<String, dynamic>> stepCollection =
        FirebaseFirestore.instance.collection("Steps");

    if (state == "Week") {
      _steps = 0;
      DateTime from = DateTime(now.year, now.month, now.day - 50);
      DateTime to = DateTime(now.year, now.month, now.day - 1);
      stepCollection
          .where('date',
              isGreaterThanOrEqualTo: formatter.format(from),
              isLessThanOrEqualTo: formatter.format(to))
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) {
          print(element.data());
          DailyStep dailyStep = DailyStep.fromJson(element.data());
          _statsData.add(dailyStep);
          setState(() {
            _steps += dailyStep.steps;
          });
        });
        setState(() {
          seriesList = _monthData(_statsData);
        });
      });
    } else if (state == "Month") {
      _steps = 0;
      DateTime from = DateTime(now.year, now.month - 7, now.day - 1);
      DateTime to = DateTime(now.year, now.month, now.day - 1);
      stepCollection
          .where('date',
              isGreaterThanOrEqualTo: formatter.format(from),
              isLessThanOrEqualTo: formatter.format(to))
          .snapshots()
          .listen((event) {
        event.docs.forEach((element) {
          DailyStep dailyStep = DailyStep.fromJson(element.data());
          _statsData.add(dailyStep);
          setState(() {
            _steps += dailyStep.steps;
          });
        });
        setState(() {
          seriesList = _monthData(_statsData);
        });
      });
    } else if (state == "Day") {
      initStepsSetup();
    }
  }

  void initStepsSetup() {
    CollectionReference<Map<String, dynamic>> stepCollection =
        FirebaseFirestore.instance.collection("Steps");
    stepCollection
        .where('date', isEqualTo: formatter.format(now))
        .snapshots()
        .listen((event) {
      setState(() {
        if (event.docs.isNotEmpty) {
          DailyStep dailyStep = DailyStep.fromJson(event.docs.first.data());
          _steps = dailyStep.steps;
          seriesList = _dailyData(List.of({dailyStep}));
        } else {
          _steps = 0;
        }
      });
    });
  }

  static List<charts.Series<DailyStep, String>> _weekData(
      List<DailyStep> data) {
    return [
      new charts.Series<DailyStep, String>(
        id: 'Week',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (DailyStep, _) => DailyStep.day,
        measureFn: (DailyStep, _) => DailyStep.steps,
        data: data,
      ),
    ];
  }

  static List<charts.Series<DailyStep, String>> _monthData(
      List<DailyStep> data) {
    return [
      new charts.Series<DailyStep, String>(
        id: 'Month',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (DailyStep, _) => DailyStep.month,
        measureFn: (DailyStep, _) => DailyStep.steps,
        data: data,
      ),
    ];
  }

  static List<charts.Series<DailyStep, String>> _dailyData(
      List<DailyStep> data) {
    return [
      new charts.Series<DailyStep, String>(
        id: 'Day',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (DailyStep, _) => DailyStep.timestamp,
        measureFn: (DailyStep, _) => DailyStep.steps,
        data: data,
      ),
    ];
  }

  @override
  void initState() {
    saveSteps(23238492);
    initPlatformState();
    initStepsSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          firstCard(size, _steps),
          //level container
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.grey.shade800),
            child: Text(
              "0/1000",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          levelBar(size, _level, _progress),
          //ad container
          Container(
            height: 60,
            width: size.width,
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/ade.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          //Statictics buttons
          Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statsButton(
                    "Day",
                    size,
                    BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5),
                    ),
                    dayButtonColor),
                statsButton("Week", size, BorderRadius.zero, weekButtonColor),
                statsButton(
                    "Month",
                    size,
                    BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    monthButtonColor),
              ],
            ),
          ),
          //Steps Counter
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.cyan),
                      borderRadius: BorderRadius.circular(100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_walk_outlined,
                        color: Colors.grey.shade600,
                        size: 40,
                      ),
                      Text(
                        "${_steps}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Steps",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                //Attributes counters
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailCircles(
                        "Distance", "0.0", "KM", Icons.location_on_outlined),
                    detailCircles("Speen", "0.0", "KM/H", Icons.speed_outlined),
                    detailCircles("Hours", "0", "Hours", Icons.alarm),
                  ],
                )
              ],
            ),
          ),
          seriesList != null
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: charts.BarChart(seriesList),
                  ),
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget statsButton(String title, Size size, BorderRadius borderRadius,
      Color backgroundColor) {
    return GestureDetector(
      onTap: () => statsChange(title),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        width: size.width * .31,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
