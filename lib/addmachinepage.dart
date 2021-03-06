import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_manage/qrpage.dart';
import 'package:http/http.dart' as http;

class MachinePage extends StatefulWidget {
  var _username,_password;
  MachinePage(this._username,this._password);
  @override
  State<StatefulWidget> createState() {
    return MachinePageState(_username,_password);
  }
}

class MachinePageState extends State<MachinePage> {
  var day = DateTime.now();
  var time = TimeOfDay.now();
  var timeNow = TimeOfDay.now();
  var dayNow = DateTime.now();
  bool checkFlag = false;
  String equipmentType, modelNumber, brandName, serialNumber;
  bool equip = false;
  bool model = false;
  bool brand = false;
  bool serial = false;
  String dropdownvalue;
  Map<String, String> details = Map();
  List<DropdownMenuItem> templates = List();
  var _templates, _response,_username,_password;
  var containerDecor = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
            offset: Offset(0.0, 0.6), color: Colors.grey, blurRadius: 25.0)
      ]);
  Future responsee;
  void initState() {
    _getTemplates();
    templates.add(
      DropdownMenuItem(
        child: Text("Add New Template"),
        value: "Add New Template",
      )
    );
    super.initState();
  }
  MachinePageState(this._username,this._password);

  void setData() {
    if (equip && model && brand && serial && (dropdownvalue != null)) {
      details["eqtype"] = equipmentType;
      details["brand"] = brandName;
      details["model"] = modelNumber;
      details["serialno"] = serialNumber;
      details["doi"] =
          ((day.toString().replaceAll(day.toString().substring(10), " ")) +
              time.toString().substring(10));
      details["tname"] = dropdownvalue;
    }
  }

  void _getTemplates() async {
    responsee = http.get("https://upnr.azurewebsites.net/gettemplates");
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      initialDate: day,
      firstDate: DateTime(1960),
      context: context,
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != day) {
      setState(() {
        day = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null && picked != time) {
      setState(() {
        time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _page = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Machine",style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: containerDecor,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("Enter Quipment Type"),
                  ),
                  TextField(
                    onChanged: (equpment) {
                      setState(() {
                        equipmentType = equpment;
                        equip = true;
                      });
                    },
                    decoration: InputDecoration(labelText: "Enter Equipment"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: containerDecor,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Enter Model",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  TextField(
                    onChanged: (_model) {
                      modelNumber = _model;
                      model = true;
                    },
                    decoration: InputDecoration(labelText: "Enter Model Name"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: containerDecor,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Enter Brand",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  TextField(
                    onChanged: (_brand) {
                      brandName = _brand;
                      brand = true;
                    },
                    decoration: InputDecoration(labelText: "Enter Brand"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: containerDecor,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Enter Serial Number",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  TextField(
                    onChanged: (serialNo) {
                      serialNumber = serialNo;
                      serial = true;
                    },
                    decoration:
                        InputDecoration(labelText: "Enter Serial Number"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: containerDecor,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Enter Date on installation\n(Default Date and time is now)",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: RaisedButton(
                            color: Color(0xFF00003f),
                            child: Text(
                              "Select Day",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: RaisedButton(
                            color: Color(0xFF00003f),
                            child: Text(
                              "Select time",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _selectTime(context);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 100.0,
              decoration: containerDecor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Select a template",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: FutureBuilder(
                      future: responsee,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int i;
                          _templates = json.decode(snapshot.data.body);
                          var data = _templates.values.toList();
                          var temps = data[0];
                          if (!checkFlag) {
                            for (i = 0; i < temps.length; i++) {
                              templates.add(DropdownMenuItem(
                                child: Text(temps[i].toString()),
                                value: temps[i],
                              ));
                            }
                            checkFlag = true;
                          }
                          return DropdownButton(
                            items: templates,
                            hint: Text("Select an Option"),
                            onChanged: (_value) {
                              setState(() {
                                dropdownvalue = _value;
                              });
                            },
                            value: dropdownvalue,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        backgroundColor: Color(0xFF00003f),
        onPressed: () {
          setState(() {
            setData();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return QRPage(details);
            }));
          });
        },
      ),
    );
    return _page;
  }
}
