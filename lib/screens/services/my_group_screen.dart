import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:kai_mobile_app/bloc/get_group_mate_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/group_mate_respose.dart';
import 'package:kai_mobile_app/model/group_mate_model.dart';

import 'package:url_launcher/url_launcher.dart';

class MyGroupScreen extends StatefulWidget {
  @override
  _MyGroupScreenState createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  @override
  void initState() {
    getGroupMateBloc.getGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Моя группа",
      
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
  
          ),
          onPressed: () {
            serviceMenu..backToMenu();
          },
        ),
        centerTitle: true,
        
      ),
      body: StreamBuilder(
          stream: getGroupMateBloc.subject,
          builder: (context, AsyncSnapshot<GroupMateResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                if(snapshot.data.error == "Авторизуйтесь"){
                  return buildAuthButton();
                }
                return Center(
                  child: Text(snapshot.data.error),
                );
              }
              return _buildListView(snapshot.data.group);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Ошибка"),
              );
            } else {
              return buildLoadingWidget();
            }
          }),
    );
  }

  Widget _buildListView(List<GroupMateModel> groupList) {
    return ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          return _buildGroupItem(groupList[index]);
        });
  }

  Widget _buildGroupItem(GroupMateModel groupMate) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: Container(
        height: 140,

        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Card(
                elevation: 0,
                  child: Container(
                    color: Theme.of(context).accentColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        groupMate.studentFIO,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                ),
              ),
            ),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16),
                  child: Container( 
                    color: Theme.of(context).primaryColor,
                    
                    child: Row(
                      children: [

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text("Телефон"),
                              SizedBox(
                                height: 12,
                              ),
                              //Text(groupMate.studentPhone),
                              Linkify(text:"${groupMate.studentPhone}",onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                    } else {
                              throw 'Could not launch $link';
                                  }
                                },)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text("E-Mail"),
                              SizedBox(
                                height: 12,
                              ),
                              Linkify(text:"${groupMate.studentEmail}",onOpen: (link) async {
                                  if (await canLaunch(link.url)) {
                                    await launch(link.url);
                                    } else {
                              throw 'Could not launch $link';
                                  }
                                },),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
