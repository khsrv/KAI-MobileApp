class ActivityModel {
  String id;
  String title;
  String desc;
  String image;
  String leader;
  String date;
  String address;
  String links;

  ActivityModel.fromJson(dynamic data) {
    this.id = data["_id"].toString().trim();
    this.title = data["title"].toString().trim();
    this.desc = data["desc"].toString().trim();
    this.image = data["image"] != null ? data["image"].toString().trim() : null;
    this.leader = data["leader"].toString().trim();
    this.date = data["schedule"].toString().trim();
    this.address = data["address"].toString().trim();
    this.links = data["links"].toString().trim();
  }
}
