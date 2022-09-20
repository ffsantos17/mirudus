/*import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Insert.dart';
import 'Player.dart';
import 'ListPlayers.dart';

Future<List<Player>> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    List players = json.decode(response.body);
    return players
        .map((player) => new Player.fromJson(player))
        .toList();
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete album.');
  }
}


//Future is n object representing a delayed computation.
Future<List<Player>> downloadJSON() async {
  final jsonEndpoint =
      "https://mirudus.000webhostapp.com/players.php";

  final response = await http.get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List players = json.decode(response.body);
    return players
        .map(

            (player) => new Player.fromJson(player))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    downloadJSON();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:  Scaffold(
        appBar:  AppBar(title: Text('MIRUDUS')),
        body:  Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child:  FutureBuilder<List<Player>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Player>? players = snapshot.data;
                return  CustomListView(players!);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              //return  a circular progress indicator.
              return  CircularProgressIndicator();
            },
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Insert()),
            );
          },
          tooltip: 'Novo Player',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
//end}


class CheckBoxInListView extends StatefulWidget {
  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  final List<SimpleModel> _items = <SimpleModel>[
    SimpleModel('InduceSmile.com', false),
    SimpleModel('Flutter.io', false),
    SimpleModel('google.com', false),
    SimpleModel('youtube.com', false),
    SimpleModel('yahoo.com', false),
    SimpleModel('gmail.com', false),
  ];
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(8),
    children: _items
        .map(
          (SimpleModel item) => CheckboxListTile(
        title: Text(item.title),
        value: item.isChecked,
        onChanged: (bool? val) {
          setState(() => item.isChecked = val!);
        },
      ),
    )
        .toList(),
  );
}

class SimpleModel {
  String title;
  bool isChecked;

  SimpleModel(this.title, this.isChecked);
}*/