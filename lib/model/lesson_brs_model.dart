class LessonBRSModel{
  String disciplineName;
  int att1;
  int maxAtt1;
  int att2;
  int maxAtt2;
  int att3;
  int maxAtt3;
  int finBall;

  LessonBRSModel.fromJson(dynamic data){
    this.disciplineName = data["DisciplineName"].toString().trim();
    this.att1 = int.parse(data["Att1"].toString().trim());
    this.maxAtt1 = int.parse(data["MaxAtt1"].toString().trim());
    this.att2 = int.parse(data["Att2"].toString().trim());
    this.maxAtt2 = int.parse(data["MaxAtt2"].toString().trim());
    this.att3 = int.parse(data["Att3"].toString().trim());
    this.maxAtt3 = int.parse(data["MaxAtt3"].toString().trim());
    this.finBall = int.parse(data["FinBall"].toString().trim());
  }

}