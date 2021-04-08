

import 'package:kai_mobile_app/model/news_model.dart';

class NewsResponse {
  final List<NewsModel> news;
  final String error;

  NewsResponse(this.news, this.error);

  NewsResponse.fromJson(List<dynamic> json)
      : news =
  (json).map((i) => new NewsModel.fromJson(i)).toList(),
        error = "";

  NewsResponse.withError(String errorValue)
      : news = List(),
        error = errorValue;
}