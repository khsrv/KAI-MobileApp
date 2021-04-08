class UserModel {
  String studId;
  String status;
  String studFio;
  String groupID;
  String groupNum;
  String profileId;
  String profileName;
  String specId;
  String specCode;
  String specName;
  String eduQualif;
  String eduCycle;
  String programForm;
  String competitionType;
  String eduLevel;
  String instId;
  String kafId;
  String instName;
  String kafName;
  String zach;

  UserModel();
  UserModel.fromJson(dynamic data) {
    this.studId = data["stud_id"];
    this.status = data["status"];
    this.studFio = data["name"];
    this.groupID = data["group"]["id"];
    this.groupNum = data["group"]["title"];
    this.profileId = data["teach_profile"]["id"];
    this.profileName = data["teach_profile"]["title"];
    this.specId = data["speciality"]["id"];
    this.specCode = data["speciality"]["code"];
    this.specName = data["speciality"]["title"];
    this.eduLevel = data["education"]["level"];
    this.eduQualif = data["education"]["qualification"];
    this.eduCycle = data["education"]["cycle"];
    this.programForm = data["form"];
    this.competitionType = data["competition"];
    this.instId = data["institute"]["id"];
    this.instName = data["institute"]["title"];
    this.kafId = data["cafedra"]["id"];
    this.kafName = data["cafedra"]["title"];
    this.zach = data["zachet_num"];
   
  }
}

// this.studId = data["StudId"];
// this.status = data["Status"];
// this.studFio = data["StudFio"];
// this.groupID = data["GroupID"];
// this.groupNum = data["GroupNum"];
// this.profileId = data["ProfileId"];
// this.profileName = data["ProfileName"];
// this.specId = data["SpecId"];
// this.specCode = data["SpecCode"];
// this.specName = data["SpecName"];
// this.eduQualif = data["EduQualif"];
// this.eduCycle = data["EduCycle"];
// this.programForm = data["ProgramForm"];
// this.competitionType = data["CompetitionType"];
// this.eduLevel = data["EduLevel"];
// this.instId = data["InstId"];
// this.kafId = data["KafId"];
// this.instName = data["InstName"];
// this.kafName = data["KafName"];
// this.zach = data["Zach"];
// this.predpr = data["Predpr"];
// this.rukFio = data["RukFio"];
// this.rabTheme = data["RabTheme"];
// this.rabProfile = data["RabProfile"];
