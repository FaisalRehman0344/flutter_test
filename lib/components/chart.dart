import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:steps_counter/models/Step.dart';

class BarChart extends StatelessWidget {

  final List<charts.Series<DailyStep, String>> dataList;
  BarChart(this.dataList);

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      dataList,
      animate: true,
      animationDuration: Duration(seconds: 4),
    );
  }
}
