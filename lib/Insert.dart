import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mirudus/funcional2List.dart';
import 'package:http/http.dart' as http;

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  TextEditingController namectl = TextEditingController();
  TextEditingController levelctl = TextEditingController();
  //text controller for TextField

  late bool error, sending, success;
  late String msg;

  String phpurl = "https://mirudus.000webhostapp.com/insert.php";
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {

    var res = await http.post(Uri.parse(phpurl), body: {
      "name": namectl.text,
      "level": dropdownValue,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if(data["error"]){
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      }else{

        namectl.text = "";
        levelctl.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }

    }else{
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  String dropdownValue = '0';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text("MIRUDUS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cadastrar Player',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            const SizedBox(height: 30),
            TextFormField(
                controller: namectl,
                decoration: InputDecoration(
                  labelText:"Nome",
                  labelStyle: TextStyle(color: Colors.black),
                )
            ),
            const SizedBox(height: 20),
            const Text("Level GC"),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['0','1','2','3','4','5','6','7','8'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ButtonTheme(
              height: 40.0,
              padding: EdgeInsets.only(left: 20, right: 20),
              child:RaisedButton(
                onPressed:(){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                  setState(() {
                    sending = true;
                  });
                  sendData();
                },
                child: Text(
                  sending?"Sending...":"SEND DATA",
                  //if sending == true then show "Sending" else show "SEND DATA";
                ),
                color: Colors.redAccent,
                colorBrightness: Brightness.dark,
                //background of button is darker color, so set brightness to dark
              ),//RaisedButton

            ),

          ],


        ),


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }
}
