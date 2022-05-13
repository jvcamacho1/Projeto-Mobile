import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/views/widgets/ButtonCustom.dart';
import 'package:project/views/widgets/InputCustom.dart';

import '../controllers/ItemsController.dart';
import '../controllers/NewItemController.dart';
import '../models/Item.dart';

class ShareList extends StatefulWidget {
  const ShareList({Key? key}) : super(key: key);

  @override
  State<ShareList> createState() => _ShareListState();
}

class _ShareListState extends State<ShareList> {
  final TextEditingController _controllerEmail = TextEditingController();
  String _errorMessage = "";
  final _formKey = GlobalKey<FormState>();

  _validateFieldsAndSave() {
    String email = _controllerEmail.text;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compartilhar Lista"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: InputCustom(
                    controller: _controllerEmail,
                    hintText: "Email",
                    autofocus: true,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ButtonCustom(
                      text: "Compartilhar Lista",
                      onPressed: () {
                        _validateFieldsAndSave();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
