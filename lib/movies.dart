/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
            title: Text('GeeksforGeeks'),
            backgroundColor: Colors.greenAccent[400],
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
              tooltip: 'Menu',
            ) //IconButton
        ), //AppBar
        body: Center(
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 175,
                          height: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ), //BoxDecoration
                        ), //Container
                        SizedBox(
                          width: 20,
                        ), //SizedBox
                        Container(
                            width: 175,
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ) //BoxDecoration
                        ) //Container
                      ], //<Widget>[]
                      mainAxisAlignment: MainAxisAlignment.center,
                    ), //Row
                    Container(
                      margin: const EdgeInsets.only(left: 300.0, right: 300.0, top: 300),
                      child: ListView.builder(
                        itemCount: players.length, // quantidade de elementos
                        // Os elementos da lista
                        itemBuilder: (context, index) {
                          // Vai ser um item de lista tipo ListTile
                          return CheckboxListTile(
                            title: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(players[index].name),
                                      ),
                                      ElevatedButton(
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Edit(player: players[index])),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(5),
                                          minimumSize: Size(0, 0),
                                          elevation: 0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: ElevatedButton(
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Edit(player: players[index])),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(5),
                                            minimumSize: Size(0, 0),
                                            elevation: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //Text(players[index].name + " | Level - " +players[index].level),
                            value: players[index].checked,
                            secondary: Container(
                              height: 35,
                              width: 35,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  'https://mirudus.000webhostapp.com/imagens/level_${players[index].level}.PNG',
                                ),
                              ),
                            ),
                            onChanged: (bool? value) {
                              setState(() {
                                players[index].checked = value!;
                              });
                            },
                          );
                        },
                      ),
                    ), //Container
                  ], //<widget>[]
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ), //Column
              ) //Padding
          ), //Container
        ) //Center
    ), //Scaffold

    debugShowCheckedModeBanner: false,
  )); //MaterialApp
}*/