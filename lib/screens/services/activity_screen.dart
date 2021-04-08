import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/get_acrivitys_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/activity_model.dart';
import 'package:kai_mobile_app/model/activitys_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/screens/detail/detail_activity_screen.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    getActivitysBloc.getActivitys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        title: Text(
          "Активности",
        ),
        centerTitle: true,
      ),
      body: _buildNewsView(),
    );
  }

  Widget _buildNewsView() {
    return StreamBuilder(
        stream: getActivitysBloc.subject.stream,
        builder: (context, AsyncSnapshot<ActivitysResponse> snapshot) {
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

  Widget _buildNewsList(List<ActivityModel> activitis) {
    return ListView.builder(
        itemCount: activitis.length,
        itemBuilder: (context, index) {
          return _buildNewsItem(activitis[index]);
        });
  }

  Widget _buildNewsItem(ActivityModel activityModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailActivityScreen(activityModel)));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Container(
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Hero(
                    tag: activityModel,
                    child: activityModel.image != null
                        ? Image.network(
                            MobileRepository.mainUrl + activityModel.image,
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
                      tag: activityModel.id,
                      child: Text(
                        activityModel.title,
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
                padding: const EdgeInsets.only(bottom: 24.0, right: 8, left: 8),
                child: Text(
                  activityModel.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
