import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController levelController;
  int? level;

  AppForm({required this.formKey, required this.nameController, required this.levelController, required this.level});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
//int _number_tickets_total = level;
var sequenceNumbers = new List<int>.generate(21, (k) => k + 1);
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always, key: widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
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
              value: widget.level,
              items: sequenceNumbers.map((int value) {
                return new DropdownMenuItem<int>(
                  value: value,
                  child: new Text(value.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  widget.level = newVal!;
                  print(widget.level);
                });
              }),
        ],
      ),
    );;
  }
}