class Consts {
  static List<TimeGeneralModel> hoursList = [
    TimeGeneralModel(angle: 360, hour: 9, isSelected: false, textAngle: 0),
    TimeGeneralModel(angle: 330, hour: 8, isSelected: false, textAngle: 30),
    TimeGeneralModel(angle: 300, hour: 7, isSelected: false, textAngle: 60),
    TimeGeneralModel(angle: 270, hour: 6, isSelected: false, textAngle: 90),
    TimeGeneralModel(angle: 240, hour: 5, isSelected: false, textAngle: 120),
    TimeGeneralModel(angle: 210, hour: 4, isSelected: false, textAngle: 150),
    TimeGeneralModel(angle: 180, hour: 3, isSelected: false, textAngle: 180),
    TimeGeneralModel(angle: 150, hour: 2, isSelected: false, textAngle: 210),
    TimeGeneralModel(angle: 120, hour: 1, isSelected: false, textAngle: 240),
    TimeGeneralModel(angle: 90, hour: 12, isSelected: false, textAngle: 270),
    TimeGeneralModel(angle: 60, hour: 11, isSelected: false, textAngle: 300),
    TimeGeneralModel(angle: 30, hour: 10, isSelected: false, textAngle: 330),
  ];
  static List<TimeGeneralModel> minutsList = [
    TimeGeneralModel(angle: 360, hour: 45, isSelected: false, textAngle: 0),
    TimeGeneralModel(angle: 330, hour: 40, isSelected: false, textAngle: 30),
    TimeGeneralModel(angle: 300, hour: 35, isSelected: false, textAngle: 60),
    TimeGeneralModel(angle: 270, hour: 30, isSelected: false, textAngle: 90),
    TimeGeneralModel(angle: 240, hour: 25, isSelected: false, textAngle: 120),
    TimeGeneralModel(angle: 210, hour: 20, isSelected: false, textAngle: 150),
    TimeGeneralModel(angle: 180, hour: 15, isSelected: false, textAngle: 180),
    TimeGeneralModel(angle: 150, hour: 10, isSelected: false, textAngle: 210),
    TimeGeneralModel(angle: 120, hour: 05, isSelected: false, textAngle: 240),
    TimeGeneralModel(angle: 90, hour: 00, isSelected: false, textAngle: 270),
    TimeGeneralModel(angle: 60, hour: 55, isSelected: false, textAngle: 300),
    TimeGeneralModel(angle: 30, hour: 50, isSelected: false, textAngle: 330),
  ];
}

class TimeGeneralModel {
  int hour;

  double angle, textAngle;

  bool isSelected;

  TimeGeneralModel({
    required this.angle,
    required this.hour,
    required this.isSelected,
    required this.textAngle,
  });
}
