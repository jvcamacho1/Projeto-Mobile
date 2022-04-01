import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/views/widgets/ButtonCustom.dart';
import 'package:project/views/widgets/InputCustom.dart';

import '../controllers/ItemsController.dart';
import '../controllers/NewItemController.dart';
import '../models/Item.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final TextEditingController _controllerNameItem = TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final ItemsController _itemsController = ItemsController();
  final NewItemController _newItemController = NewItemController();
  String _errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  
  _validateFieldsAndSave() {
    String nameItem = _controllerNameItem.text;
    String amountItem = _controllerAmount.text;
    String priceItem = _controllerPrice.text;

    if (nameItem.isNotEmpty && amountItem.isNotEmpty && priceItem.isNotEmpty) {
      setState(() {
        _errorMessage = "";
      });

      _newItemController.insertItem(nameItem, amountItem, priceItem);

      Navigator.pop(context);
      Navigator.pushNamed(context, "/lista-compras");
    } else {
      setState(() {
        _errorMessage = "Todos os campos são obrigatórios!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo item"),
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
                    controller: _controllerNameItem,
                    hintText: "Nome do item",
                    autofocus: true,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: InputCustom(
                    controller: _controllerAmount,
                    hintText: "Quantidade",
                    autofocus: true,
                    textInputType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: InputCustom(
                    controller: _controllerPrice,
                    hintText: "Preço",
                    autofocus: true,
                    textInputType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ButtonCustom(
                      text: "Cadastrar item",
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
