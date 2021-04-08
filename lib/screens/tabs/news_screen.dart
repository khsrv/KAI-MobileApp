import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile_app/bloc/get_news_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/news_model.dart';
import 'package:kai_mobile_app/model/news_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/style/constant.dart';

import '../detail/detail_news_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    getNewsBloc.getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Новости",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildNewsView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNewsView() {
    return StreamBuilder(
        stream: getNewsBloc.subject.stream,
        builder: (context, AsyncSnapshot<NewsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Center(
                child: Text(snapshot.data.error),
              );
            }
            return _buildNewsList(snapshot.data.news.reversed.toList());
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildNewsList(List<NewsModel> news) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return _buildNewsItem(news[index]);
        });
  }

  Widget _buildNewsItem(NewsModel newsModel) {
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(newsModel.date);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailNewsScreen(newsModel)));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        child: Card(
          elevation: 1,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Hero(
                      tag: newsModel,
                      child: newsModel.image != null
                          ? Image.network(
                              MobileRepository.mainUrl + newsModel.image,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            )
                          : Container(color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: newsModel.date,
                        child: Text(
                          newsModel.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                  child: Text(
                    newsModel.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, right: 16),
                    child: Text(
                      "Опубликовано: ${dateTime.day}.${dateTime.month}.${dateTime.year}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: kHintTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
