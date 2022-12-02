import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'form.dart';

class Insert extends StatefulWidget {
  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  // Required for form validations
  final formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController = new TextEditingController();
  TextEditingController levelController = new TextEditingController();
  int level = 1;

  // Http post request to create new data
  Future _createStudent() async {
    return await http.post(
      Uri.parse("${baseUrl}create.php"),
      body: {
        "player_nome": nameController.text,
        "player_level": level.toString()
      },
    );
  }

  void _onConfirm(context) async {
    await _createStudent().then((_) => Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false));
  }

  var sequenceNumbers = new List<int>.generate(21, (k) => k + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inserir"),
      ),
      bottomNavigationBar: SizedBox(
        height: 58,
        child: //some widget )
            BottomAppBar(
          child: ElevatedButton(
            child: Text("SALVAR"),
            onPressed: () {
              _onConfirm(context);
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
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
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
