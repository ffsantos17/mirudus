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

  // Http post request
  Future editStudent() async {
    print(baseUrl);
    return await http.post(
      Uri.parse("${baseUrl}edit.php"),
      body: {
        "id": widget.player.id.toString(),
        "player_nome": nameController.text,
        "player_level": levelController.text
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
  }

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
