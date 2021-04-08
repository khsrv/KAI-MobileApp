import 'package:flutter/material.dart';
import 'package:kai_mobile_app/bloc/service_menu_bloc.dart';

import 'package:kai_mobile_app/widgets/weather_widget.dart';

class ServiceMenuScreen extends StatefulWidget {
  @override
  _ServiceMenuScreenState createState() => _ServiceMenuScreenState();
}

class _ServiceMenuScreenState extends State<ServiceMenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Сервисы",
        ),
        centerTitle: true,

        elevation: 0,
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
              Container(
                height: MediaQuery.of(context).size.height/2,
                  child: Padding(
                    padding: EdgeInsets.only( left: 15, right: 15),
                    child: Container(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 8,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return _buildServiceMenuItem(index);
                      }),
                    ),
                  ),
              ),
                Container(
                child: Column(
                  children: [buildWeatherWidget(context),]
                  ),
              ), 
              
          ],
        ),
      ),
    );
  }

  Widget _buildServiceMenuItem(int index) {

    IconData icon = Icons.event_note;
    String label;
    Color startColor;
    Color finishColor;
    switch(index){
      case 0:
        icon = Icons.event_note_outlined;
        label = "Занятия";
        startColor = Color(0xFF2AF598);
        finishColor =Color(0xFF009EFD);
        break;
      case 1:
        icon = Icons.event_available_outlined;
        label = "Экзамены";
        startColor = Color(0xFFFF6480);
        finishColor =Color(0xFFF22E63);
        break;
      case 2:
        icon = Icons.group_outlined;
        label = "Моя группа";
        startColor = Color(0xFF1BB0DF);
        finishColor =Color(0xFF138BDB);
        break;
      case 3:
        icon = Icons.school_outlined;
        label = "БРС";
        startColor = Color(0xFF6B6BF9);
        finishColor =Color(0xFFCA6CFB);
        break;
      case 4:
        icon = Icons.location_on;
        label = "Карта";
        startColor = Color(0xFFFFD969);
        finishColor =Color(0xFFFFAB86);
        break;
      case 5:
        icon = Icons.directions_run_outlined;
        label = "Активности";
        startColor = Color(0xFFFF7569);
        finishColor =Color(0xFFFF4E54);
        break;
      case 6:
        icon = Icons.text_snippet_outlined;
        label = "Документы";
        startColor = Color(0xFFFFBD06);
        finishColor =Color(0xFFDB13C0);
        break;
      case 7:
        icon = Icons.done_outline;
        label = "Контроль";
        startColor = Color(0xFFB7B7B7);
        finishColor =Color(0xFF1F4C6A);
        break;
    }
    return FlatButton(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [startColor, finishColor],
                  tileMode: TileMode.mirror,
                ).createShader(bounds),      
                child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              label,
              
            ),
          ],
        ),
      ),
      onPressed: (){

        serviceMenu.pickItem(index);
      },
    );
  }
}
