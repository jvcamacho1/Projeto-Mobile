import 'package:flutter/material.dart';

import '../controllers/ItemsController.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<String> itemsMenu = ["Sair"];
  final ItemsController _itemsController = ItemsController();

  Widget listaDeItens() {
    return ListView.builder(
        itemCount: _itemsController.viewList().length,
        itemBuilder: (BuildContext context, int index) {

          return  _itemsController.viewList() == null ? Container() : GestureDetector(
            onTap: () {},
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Produto: ${_itemsController.getItemName(index)}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Quantidade: ${_itemsController.getItemAmount(index).toString()}"),
                            Text(
                                "R\$: ${_itemsController.getItemPrice(index).toString()}"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        color: Colors.red,
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Confirmar"),
                                  content:
                                      Text("Deseja realmente excluir o item?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Cancelar",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.red,
                                      child: Text(
                                        "Remover",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                       _itemsController.remove(index);
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(context, "/lista-compras");
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _chooseItemMenu(String chooseItem) {
    switch (chooseItem) {
      case "Entrar / cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Sair":
        _logoutUser();
        break;
    }
  }

  _logoutUser() async {
    Navigator.pushNamed(context, "/login");
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _chooseItemMenu,
            itemBuilder: (context) {
              return itemsMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/novo-item");
        },
      ),
      body: listaDeItens()
    );
  }
}
