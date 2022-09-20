import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Player.dart';


//Future is n object representing a delayed computation.
Future<List<Player>> downloadJSON() async {
  final jsonEndpoint =
      "https://mirudus.000webhostapp.com";

  final response = await http.get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List players = json.decode(response.body);
    return players
        .map((player) => new Player.fromJson(player))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('MIRUDUS')),
        body: Center(

        ),
      ),
    );
  }
}
