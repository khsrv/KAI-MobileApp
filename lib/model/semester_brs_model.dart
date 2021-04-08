class SemestrModel{
  int semesterNum;
  SemestrModel.fromJson(dynamic data){
    this.semesterNum = int.parse(data["Semestr"].toString().trim());
  }
  SemestrModel();
  SemestrModel.withNum(int semesterNum){
    this.semesterNum = semesterNum;
  }
}