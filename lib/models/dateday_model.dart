class DateDayModel {
  String dateDay;
  String hour;
  String student;

  DateDayModel({this.dateDay, this.hour, this.student});

  DateDayModel.fromJson(Map<String, dynamic> json) {
    dateDay = json['DateDay'];
    hour = json['Hour'];
    student = json['Student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateDay'] = this.dateDay;
    data['Hour'] = this.hour;
    data['Student'] = this.student;
    return data;
  }
}
