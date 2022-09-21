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

  // Http post request to create new data
  Future _createStudent() async {
    return await http.post(Uri.parse(
      "${baseUrl}create.php"),
      body: {
        "player_nome": nameController.text,
        "player_level": levelController.text
      },
    );
  }

  void _onConfirm(context) async {
    await _createStudent();

    // Remove all existing routes until the Home.dart, then rebuild Home.
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inserir"),
      ),
      bottomNavigationBar: SizedBox(height: 58, child: //some widget )
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
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              levelController: levelController,
            ),
          ),
        ),
      ),
    );
  }
}