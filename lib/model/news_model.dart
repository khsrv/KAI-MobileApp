class NewsModel {
  bool isActive;
  String id;
  String title;
  String desc;
  String date;
  String image;
  

  NewsModel.fromJson(dynamic data) {
    this.isActive = data["isActive"].toString()=="false"?false:true;
    this.id = data["_id"].toString().trim();
    this.title = data["title"].toString().trim();
    this.desc = data["desc"].toString().trim();
    this.date = data["date"].toString().trim();
    this.image = data["image"]!=null?data["image"].toString().trim():null;
  }
}
