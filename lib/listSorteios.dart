import 'package:flutter/material.dart';
import 'package:mirudus/Insert.dart';
import 'dart:convert';
import 'api.dart';
import 'edit.dart';
import 'package:http/http.dart' as http;

// Vamos precisar de uma aplicação com estado
class SorteiosListView extends StatefulWidget {
  @override
  _SorteiosListViewState createState() => _SorteiosListViewState();
}

class _SorteiosListViewState extends State<SorteiosListView> {
  bool loading = true;

  List<Sorteio> sorteios = List<Sorteio>.empty(); // Lista dos players

  // Construtor, atualiza com setState a lista de filmes.
  _SorteiosListViewState() {
    API.getSorteios().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        sorteios = lista.map((model) => Sorteio.fromJson(model)).toList();
        loading = false;
      });
    });
  }

  // Método build sobrecarregado que vai construir nossa página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MIRUDUS")
      ),
      // Aqui vem nossa lista
      body: Center(
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                      child: loading? const Center(
                        child: CircularProgressIndicator(),
                      ) : Expanded(
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0,0,20),
                            child:ListView.builder(
                              itemCount: sorteios.length, // quantidade de elementos
                              // Os elementos da lista
                              itemBuilder: (context, index) {
                                // Vai ser um item de lista tipo ListTile
                                return Card(
                                  child: ListTile(
                                    title: Text(sorteios[index].time1),
                                  ),
                                );
                              },
                            ),
                          )

                      )
                  ),
                ], //<widget>[]
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ), //Column
            ) //Padding
        ), //Container
      )
      ,
      /*floatingActionButton: FloatingActionButton(
          child: Icon(Icons.change_circle_outlined),
          onPressed: listarApenasMarcados,
        )*/
    );
  }


}
