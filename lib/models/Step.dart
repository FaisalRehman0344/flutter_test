class DailyStep {
  int steps;
  String date;
  String day;
  String month;
  String timestamp;

  DailyStep(
      {required this.steps,
      required this.date,
      required this.day,
      required this.month,
      required this.timestamp});

  factory DailyStep.fromJson(Map<String, dynamic> data) {
    final int steps = data['steps'] as int;
    final String date = data['date'] as String;
    final String day = data['day'] as String;
    final String month = data['month'] as String;
    final String timeStamp = data['timestamp'] as String;
    return DailyStep(steps: steps, date: date, month: month, day: day,timestamp: timeStamp);
  }

  Map<String, dynamic> toJson() {
    return {
      "steps": this.steps,
      "date": this.date,
      "day": this.day,
      "month": this.month,
      "timestamp":this.timestamp
    };
  }
}
