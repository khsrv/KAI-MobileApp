import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kai_mobile_app/bloc/control_type_bloc.dart';
import 'package:kai_mobile_app/bloc/get_reports_bloc.dart';
import 'package:kai_mobile_app/bloc/send_report_bloc.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';
import 'package:kai_mobile_app/elements/auth_button.dart';
import 'package:kai_mobile_app/elements/loader.dart';
import 'package:kai_mobile_app/model/report_response.dart';
import 'package:kai_mobile_app/model/reports_model.dart';
import 'package:kai_mobile_app/model/reports_response.dart';
import 'package:kai_mobile_app/repository/mobile_repository.dart';
import 'package:kai_mobile_app/style/constant.dart';

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  File _selectedFile;
  bool _inProcess = false;

  final _reportController = TextEditingController();

  @override
  void initState() {
    getReportsBloc..getReports();
    super.initState();
  }

  @override
  void dispose() {
    _reportController.clear();
    _reportController.dispose();
    super.dispose();
  }

  Widget _buildReportTextField() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).cardColor),
            height: 60.0,
            child: TextField(
              controller: _reportController,
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                icon: IconButton(
                  icon: Icon(
                    Icons.report,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 20,
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 20),
                              child: FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                          content: Container(
                            height: 300,
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Text(
                              controlInformation,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        );
                      }),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 5),
                /*prefix: IconButton(
                  icon: Icon(
                    Icons.report,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 15,
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                          content: Container(
                            height: 300,
                            padding: EdgeInsets.all(25),
                            alignment: Alignment.center,
                            child: Text(
                              controlInformation,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        );
                      }),
                ),*/
                hintText: 'Введите проблему',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetPhotoLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          Text("Добавьте фото", style: Theme.of(context).textTheme.headline5),
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Color(0xFF182633),
    content: StreamBuilder<ReportResponse>(
        stream: sendReportBloc.subject.stream,
        builder: (context, AsyncSnapshot<ReportResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.text != null && snapshot.data.text.length > 0) {
              return Text(
                snapshot.data.text,
                style: TextStyle(
                  color: Color(0xFF3985c0),
                ),
              );
            }
          }
          return SizedBox();
        }),
    action: SnackBarAction(
      label: 'Ок',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );

  Widget _buildSendReportBtn() {
    return Container(
      padding: EdgeInsets.all(30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: () async {
          await sendReportBloc.sendReport(
              _selectedFile, _reportController.text);
          Scaffold.of(context).showSnackBar(snackBar);
          if (sendReportBloc.subject.stream.value.text ==
              "Ваша заявка принята") {
            setState(() {
              _selectedFile = null;
            });
            _reportController.clear();
            getReportsBloc..getReports();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          'Отправить',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Image.file(
          _selectedFile,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Theme.of(context).primaryColor,
            toolbarTitle: "Обрезать",
            statusBarColor: Theme.of(context).accentColor,
            backgroundColor: Colors.white,
            toolbarWidgetColor: Theme.of(context).accentColor,
            activeControlsWidgetColor: Theme.of(context).accentColor,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
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
          "Контроль",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildAddTypeCheck(),
          Expanded(
            child: StreamBuilder(
              stream: controlTypeBloc.addTypeStream,
              initialData: controlTypeBloc.defAddType,
              // ignore: missing_return
              builder: (context, AsyncSnapshot<ControlTypeItem> snapshot) {
                switch (snapshot.data) {
                  case ControlTypeItem.ADD:
                    return _buildAddReport();
                  case ControlTypeItem.LIST:
                    return _buildExamsView();
                  // ignore: empty_statements
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExamsView() {
    return StreamBuilder(
        stream: getReportsBloc.subject.stream,
        builder: (context, AsyncSnapshot<ReportsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              if (snapshot.data.error == "Авторизуйтесь") {
                return buildAuthButton();
              }
              return Center(
                child: Text(snapshot.data.error),
              );
            }
            return _buildReportsList(snapshot.data);
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildReportsList(ReportsResponse lessonsResponse) {
    List<ReportsModel> lessons = lessonsResponse.reports;
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return _buildReportsItem(lessons[index], index);
        });
  }

  Widget _buildReportsItem(ReportsModel reportsModel, int index) {
    DateTime dateTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(reportsModel.created);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: reportsModel.image != null
                      ? Image.network(
                          MobileRepository.mainUrl + reportsModel.image,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )
                      : Container(color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Заявка №${index + 1}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Текст заявки: ${reportsModel.message}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        "Статус: ${reportsModel.status}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: kHintTextStyle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddReport() {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildReportTextField(),
              _buildSetPhotoLabel(),
              getImageWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      elevation: 0,
                      minWidth: 150,
                      highlightElevation: 3,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Камера",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      }),
                  MaterialButton(
                      elevation: 0,
                      minWidth: 150,
                      color: Colors.white,
                      highlightElevation: 3,
                      child: Text(
                        "Из устройства",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      })
                ],
              ),
              _buildSendReportBtn(),
            ],
          ),
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: buildLoadingWidget(),
                ),
              )
            : Center(),
        StreamBuilder<ReportResponse>(
            stream: sendReportBloc.subject.stream,
            builder: (context, AsyncSnapshot<ReportResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.text == "Loading") {
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: buildLoadingWidget(),
                  );
                } else {
                  return Center();
                }
              }
              return SizedBox();
            }),
      ],
    );
  }

  Widget _buildAddTypeCheck() {
    return StreamBuilder(
        stream: controlTypeBloc.addTypeStream,
        initialData: controlTypeBloc.defAddType,
        builder: (context, AsyncSnapshot<ControlTypeItem> snapshot) {
          return Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    controlTypeBloc.pickWeek(0);
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Добавить",
                        style: snapshot.data == ControlTypeItem.ADD
                            ? Theme.of(context).textTheme.headline3
                            : Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  height: 25,
                  width: 1,
                  child: Container(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    controlTypeBloc.pickWeek(1);
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Мои заявки",
                        style: snapshot.data == ControlTypeItem.LIST
                            ? Theme.of(context).textTheme.headline3
                            : Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          );
        });
  }
}
