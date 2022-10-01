import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ListPlayers.dart';
import 'api.dart';
import 'form.dart';

class Edit extends StatefulWidget {
  final Player player;

  Edit({required this.player});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // This is  for form validations
  final formKey = GlobalKey<FormState>();

  // This is for text onChange
  late TextEditingController nameController;
  late TextEditingController levelController;
  late int level;

  // Http post request
  Future editStudent() async {
    print(baseUrl);
    print(level);
    return await http.post(
      Uri.parse("${baseUrl}edit.php"),
      body: {
        "id": widget.player.id.toString(),
        "player_nome": nameController.text,
        "player_level": level.toString()
      },
    );

  }

  void _onConfirm(context) async {
    await editStudent();
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.player.name);
    levelController =
        TextEditingController(text: widget.player.level.toString());
    super.initState();
    level = int.parse(widget.player.level);
  }
  var sequenceNumbers = new List<int>.generate(21, (k) => k + 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar"),
      ),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: //some
            BottomAppBar(
          child: ElevatedButton(
            child: Text('SALVAR'),
            onPressed: () {
              _onConfirm(context);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              autovalidateMode: AutovalidateMode.always, key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Player'),
                  ),
                  /*TextFormField(
            controller: widget.levelController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Level'),
          ),*/
                  SizedBox(height: 20),
                  Text("Level"),
                  DropdownButton<int>(
                      hint: Text("Level"),
                      value: level,
                      items: sequenceNumbers.map((int value) {
                        return new DropdownMenuItem<int>(
                          value: value,
                          child: new Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          level = newVal!;
                          print(level);
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
