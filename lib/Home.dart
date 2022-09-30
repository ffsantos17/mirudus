import 'package:flutter/material.dart';

import 'ListPlayers.dart';
import 'listSorteios.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    PlayersListView(),
    SorteiosListView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        selectedItemColor: Colors.black,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Players"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "Sorteios"
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
