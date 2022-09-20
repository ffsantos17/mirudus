import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController levelController;

  AppForm({required this.formKey, required this.nameController, required this.levelController});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {


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
          TextFormField(
            controller: widget.levelController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Level'),
          ),
        ],
      ),
    );;
  }
}