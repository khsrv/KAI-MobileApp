
class ExamModel{
  String examDate;
  String examTime;
  String disciplineName;
  String audNum;
  String buildNum;
  String prepodName;

  ExamModel.fromJson(dynamic data){
    this.examDate = data["ExamDate"].toString().trim();
    this.examTime = data["ExamTime"].toString().trim();
    this.disciplineName = data["DisciplineName"].toString().trim();
    this.audNum = data["AudNum"].toString().trim();
    this.buildNum = data["BuildNum"].toString().trim();
    this.prepodName = data["PrepodName"].toString().trim();
  }

}