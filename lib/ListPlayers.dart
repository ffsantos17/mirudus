import 'package:flutter/material.dart';
import 'package:mirudus/Insert.dart';
import 'dart:convert';
import 'api.dart';
import 'edit.dart';

// Vamos precisar de uma aplicação com estado
class PlayersListView extends StatefulWidget {
  @override
  _PlayersListViewState createState() => _PlayersListViewState();
}

class _PlayersListViewState extends State<PlayersListView> {

  var time1 = [];
  var time2 = [];
  int score1 = 0;
  int score2 = 0;
  List<Player> players = List<Player>.empty(); // Lista dos players

  // Construtor, atualiza com setState a lista de filmes.
  _PlayersListViewState() {
    API.getPlayers().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        players = lista.map((model) => Player.fromJson(model)).toList();
      });
    });
  }


  /* Aqui é como separamos apenas os registros marcados */
  void listarApenasMarcados() {
    List<Player> itensMarcados =
    List.from(players.where((player) => player.checked));
    var time1 = [];
    var time2 = [];
    int score1 = 0;
    int score2 = 0;
    print(itensMarcados);
    itensMarcados.shuffle();
    itensMarcados
        .sort((a, b) => int.parse(b.level).compareTo(int.parse(a.level)));

    setState(() {

      itensMarcados.forEach((player) {
        print(player.name);
        if (score1 > score2 && time2.length < time1.length) {
          int level = int.parse(player.level);
          time2.add(player.name);
          score2 = level + score2;
          print('time2 ${time2}-${score2}');
        } else {
          int level = int.parse(player.level);
          time1.add(player.name);
          score1 = level + score1;
          print('time1 ${time1}-${score1}');
        }
      });
    });
    print('$time1 - Média time = ${score1 / time1.length}');
    print('$time2 - Média time = ${score2 / time2.length}');
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Método build sobrecarregado que vai construir nossa página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Players"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.amber,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Insert()),
                );
              },
            )
          ],
        ),
        // Aqui vem nossa lista
        body: Center(
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 375,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text('$score1')
                            ],
                          ),
                        ), //Container
                        const SizedBox(
                          width: 20,
                        ), //SizedBox
                       /* Container(
                            width: 175,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                            ) //BoxDecoration
                        ) */
                      ], //<Widget>[]
                      mainAxisAlignment: MainAxisAlignment.center,
                    ), //Row
                    Container(
                      child: Expanded(
                        child:Padding(
                          padding: const EdgeInsets.fromLTRB(400, 0,400,0),
                          child:ListView.builder(
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
                                //subtitle: Text("Level - " +players[index].level),
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
                        )

                      )
                    ), //Container
                  ], //<widget>[]
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ), //Column
              ) //Padding
          ), //Container
        )
        ,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.group),
          onPressed: listarApenasMarcados,
        ));
  }


}

/*
ListTile(
            // Uma imagem de avatar redondinho com a imagem do filme
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                movies[index].image,
              ),
            ),
            // No título é o nome do filme
            title: Text(
              movies[index].name,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            // No subtítulo colocamos o link
            subtitle: Text(movies[index].link),
            // Ação de clicar
            onTap: () {
              // Abrimos uma nova página, outra classe, que está no arquivo
              // detail.dart. Veja que é um MaterialPageRote, tipo o
              // MaterialApp, só que é só uma página nova.
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => DetailPage(movies[index]),
                ),
              );
            },
          )
 */
