class ReportsModel {
  String id;
  String status;
  String message;
  String image;
  String created;
  

  ReportsModel.fromJson(dynamic data) {
    this.id = data["_id"].toString().trim();
    this.status = data["status"].toString().trim();
    this.message = data["message"].toString().trim();
    this.image = data["image"] != null ? data["image"].toString().trim() : null;
    this.created = data["created"].toString().trim();
  }
}
