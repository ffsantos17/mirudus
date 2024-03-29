import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirudus/Insert.dart';
import 'dart:convert';
import 'api.dart';
import 'edit.dart';
import 'package:http/http.dart' as http;

class PlayersListView extends StatefulWidget {
  @override
  _PlayersListViewState createState() => _PlayersListViewState();
}

class _PlayersListViewState extends State<PlayersListView> {
  bool loading = true;
  var time1 = [];
  var time2 = [];
  int score1 = 0;
  int score2 = 0;
  int _counter = 0;
  double media1 = 0;
  double media2 = 0;
  List<Player> players = List<Player>.empty();

  _PlayersListViewState() {
    API.getPlayers().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        players = lista.map((model) => Player.fromJson(model)).toList();
        loading = false;
      });
    });
  }
  Future _insertSorteio(media1, media2) async {
    return await http.post(Uri.parse(
        "${baseUrl}insert_sorteio.php"),
      body: {
        "sorteio_time1": time1.toString(),
        "sorteio_time2": time2.toString(),
        "sorteio_mediaTime1": media1.toString(),
        "sorteio_mediaTime2": media2.toString(),
        "sorteio_horario": DateTime.now().toString()
      },
    );
  }



  void listarApenasMarcados() {
    List<Player> itensMarcados =
    List.from(players.where((player) => player.checked));
    time1 = [];
    time2 = [];
    score1 = 0;
    score2 = 0;
    media1 = 0;
    media2 = 0;

    itensMarcados.shuffle();
    itensMarcados.sort((a, b) => int.parse(b.level).compareTo(int.parse(a.level)));

    setState(() {
      //Realiza sorteio do time
      var pos = 0;
      itensMarcados.forEach((player) {
        if(pos == 8){
          time2.add(player.name);
          score2 = int.parse(player.level) + score2;
        }else if(pos == 9){
          time1.add(player.name);
          score1 = int.parse(player.level) + score1;
        }else {
          if (score1 > score2 && time2.length <= time1.length) {
            int level = int.parse(player.level);
            time2.add(player.name);
            score2 = level + score2;
          } else {
            int level = int.parse(player.level);
            time1.add(player.name);
            score1 = level + score1;
          }
        }
        pos++;
      });
    });
    media1 = score1/time1.length;
    media2 = score2/time2.length;
    _insertSorteio(media1, media2);
    Clipboard.setData(ClipboardData(text: "Times\n${time1.toString()} - ${media1}\n${time2.toString()} - ${media2}"));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MIRUDUS"),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.change_circle_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  List<Player> itensMarcados =
                  List.from(players.where((player) => player.checked));
                  final playersSelecionados = [];
                  itensMarcados.forEach((player) {
                    playersSelecionados.add(player.id);
                  });
                  setState(() {
                    loading = true;
                  });
                  API.atualizaPlayers(playersSelecionados).then((response) {
                    API.getPlayers().then((response) {
                      setState(() {
                        Iterable lista = json.decode(response.body); // Usamos um iterator
                        players = lista.map((model) => Player.fromJson(model)).toList();
                        loading = false;
                        time1 = [];
                        time2 = [];
                        score1 = 0;
                        score2 = 0;
                        _counter = 0;
                        media1 = 0;
                        media2 = 0;
                      });
                    });
                  });
                  print(playersSelecionados);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Insert()),
                  ).then((_) => setState(() {}));
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Quantidade Marcados: $_counter',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 2)),
                            SelectableText('Time 1 | Média Time: ${media1}\n'
                                '$time1\n'
                                'Time 2 | Média Time: ${media2}\n'
                                '$time2',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 2)),
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ), //Row
                  Container(
                      child: loading? const Center(
                        child: CircularProgressIndicator(),
                      ) : Expanded(
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0,0,20),
                            child:ListView.builder(
                              itemCount: players.length,
                              itemBuilder: (context, index) {
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
                                                ).then((_) => setState(() {}));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(5),
                                                minimumSize: Size(0, 0),
                                                elevation: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  value: players[index].checked,
                                  secondary: Container(
                                    height: 35,
                                    width: 35,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        'imagens/level_${players[index].level}.PNG',
                                      ),
                                    ),
                                  ),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value == true){
                                        _counter++;
                                      }else{
                                        _counter--;
                                      }
                                      players[index].checked = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          )

                      )
                  ),
                  ElevatedButton(
                      onPressed: listarApenasMarcados,
                      child: Text("Sortear"))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ), //Column
            ) //Padding
        ), //Container
      ),

    );
  }


}
