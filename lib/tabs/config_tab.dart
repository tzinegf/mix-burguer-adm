import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConfigTab extends StatefulWidget {
  @override
  _ConfigTabState createState() => _ConfigTabState();
}

class _ConfigTabState extends State<ConfigTab> {
  String iniTime = "08:00:00";
  String fimTime = "18:00:00";

  DateTime fimTime1;
  DateTime iniTime1;

  bool day0 = false;
  bool day1 = false;
  bool day2 = false;
  bool day3 = false;
  bool day4 = false;
  bool day5 = false;
  bool day6 = false;

  List daysOfWeek = [];
  Firestore _firestore = Firestore.instance;

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
            trailing: Checkbox(
                value: day0,
                onChanged: (bool value) {
                  setState(() {
                    day0 = value;
                  });
                  if (value) {
                    daysOfWeek.insert(0, 0);
                  } else {
                    daysOfWeek.insert(0, null);
                  }
                }),
          ),
          ListTile(
              title: Text("Segunda"),
              trailing: Checkbox(
                  value: day1,
                  onChanged: (bool value) {
                    setState(() {
                      day1 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(1, 1);
                    } else {
                      daysOfWeek.insert(1, null);
                    }
                  })),
          ListTile(
              title: Text("Terça"),
              trailing: Checkbox(
                  value: day2,
                  onChanged: (bool value) {
                    setState(() {
                      day2 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(2, 2);
                    } else {
                      daysOfWeek.insert(2, null);
                    }
                  })),
          ListTile(
              title: Text("Quarta"),
              trailing: Checkbox(
                  value: day3,
                  onChanged: (bool value) {
                    setState(() {
                      day3 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(3, 3);
                    } else {
                      daysOfWeek.insert(3, null);
                    }
                  })),
          ListTile(
              title: Text("Quinta"),
              trailing: Checkbox(
                  value: day4,
                  onChanged: (bool value) {
                    setState(() {
                      day4 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(4, 4);
                    } else {
                      daysOfWeek.insert(4, null);
                    }
                  })),
          ListTile(
              title: Text("Sexta"),
              trailing: Checkbox(
                  value: day5,
                  onChanged: (bool value) {
                    setState(() {
                      day5 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(5, 5);
                    } else {
                      daysOfWeek.insert(5, null);
                    }
                  })),
          ListTile(
              title: Text("Sabado"),
              trailing: Checkbox(
                  value: day6,
                  onChanged: (bool value) {
                    setState(() {
                      day6 = value;
                    });
                    if (value) {
                      daysOfWeek.insert(6, 6);
                    } else {
                      daysOfWeek.insert(6, null);
                    }
                  })),
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
                  DatePicker.showTimePicker(context, onChanged: (date) async {
                    String formattedHora = DateFormat('Hms').format(date);
                    iniTime1 = date;
                    setState(() {
                      iniTime = formattedHora;
                    });
                  },
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: LocaleType.pt);
                },
                child: Text(
                  ' $iniTime',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ),
          ListTile(
            title: Text("Final"),
            trailing: FlatButton(
                onPressed: () {
                  DatePicker.showTimePicker(context, onChanged: (date) async {
                    String formattedHora = DateFormat('Hms').format(date);
                    fimTime1 = date;
                    setState(() {
                      fimTime = formattedHora;
                    });
                  },
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: LocaleType.pt);
                },
                child: Text(
                  ' $fimTime',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ),
          Divider(),
          RaisedButton(
            child: Text("Salvar"),
            onPressed: () {
              setTime(iniTime1, fimTime1, daysOfWeek);
            },
          )
        ],
      ),
    );
  }

  void setTime(DateTime ti, DateTime tf, List daysOfWeek) async {
    await _firestore
        .collection('routine')
        .add({'fimTime': tf, 'initTime': ti, 'daysOfWeek': daysOfWeek});
    print(daysOfWeek);

    this.daysOfWeek = [];
  }
}
