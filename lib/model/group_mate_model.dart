
class GroupMateModel {

  String studentFIO;
  int isStarosta;
  String studentEmail;
  String studentPhone;


  GroupMateModel.fromJson(dynamic data){
    this.isStarosta = int.parse(data["IsStarosta"].toString().trim());
    this.studentFIO = data["StudentFIO"].toString().trim();
    this.studentEmail = data["StudentEmail"].toString().trim();
    this.studentPhone = data["StudentPhone"].toString().trim();
  }
}