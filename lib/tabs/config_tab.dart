import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ConfigTab extends StatefulWidget {

  @override
  _ConfigTabState createState() => _ConfigTabState();
}

class _ConfigTabState extends State<ConfigTab> {
  String iniTime;
  String fimTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Text(
            "Dias de Funcionamento",
            style: TextStyle(
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(
            title: Text("Domingo"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Segunda"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Terça"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Quarta"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Quinta"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Sexta"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          ListTile(
            title: Text("Sabado"),
            trailing: Checkbox(value: false, onChanged: null),
          ),
          Divider(),
          Text(
            "Horario de Funcionamento",
            style: TextStyle(
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(
            title: Text("Inicial"),
            trailing: FlatButton(
                onPressed: () {


                  DatePicker.showTimePicker(context, onChanged: (date) {
                    print('confirm $date');
                    setState(() {
                      iniTime= date.hour.toString()+':'+date.minute.toString()+':'+date.second.toString();
                    });

                  },
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: LocaleType.pt);
                },
                child: Text(
                  ' $iniTime',
                  style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),
                )),


          ),
          ListTile(
            title: Text("Final"),
            trailing: FlatButton(
                onPressed: () {


                  DatePicker.showTimePicker(context, onChanged: (date) {
                    print('confirm $date');
                    setState(() {
                      fimTime= date.hour.toString()+':'+date.minute.toString()+':'+date.second.toString();
                    });

                  },
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: LocaleType.pt);
                },
                child: Text(
                  ' $fimTime',
                  style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),
                )),


          ),

        ],
      ),
    );
  }
}
