import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project/models/Item.dart';

class ItemsController {
  ItemsController();

  static List<Item> items = [];

  viewList2() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var usuarioLogado = auth.currentUser;
    var _idUsuarioLogado = usuarioLogado?.uid;

    var data = await FirebaseFirestore.instance
        .collection("meus_items")
        .doc(_idUsuarioLogado)
        .collection("Items")
        .get();

    List<String> ItemsIds = [];
    for (var i = 0; i < data.docs.length; i++) {
      ItemsIds.add(data.docs[i].id.toString());
    }

    for (var item in ItemsIds) {
      var dataItem = await FirebaseFirestore.instance
          .collection("meus_items")
          .doc(_idUsuarioLogado)
          .collection("Items")
          .doc(item)
          .get();

      Item itemAux = Item();
      itemAux.price = dataItem.data()!['price'];
      itemAux.name = dataItem.data()!['name'];
      itemAux.amount = dataItem.data()!['amout'];
      itemAux.active = dataItem.data()!['active'];
      itemAux.id = dataItem.data()!['id'];

      var count = 0;
      if (items.length <= 0) {
        items.add(itemAux);
      } else {
        for (var i = 0; i < items.length; i++) {
          if (items[i].name == itemAux.name) {
            count++;
          }
        }
        if (count == 0) {
          items.add(itemAux);
        }
      }
    }
  }

  count() {
    return items.length;
  }

  add(Item item) {
    items.add(item);
  }

  remove(int index) {
    var item = items[index];
    if (item.id.isEmpty) {
      viewList2();
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      var usuarioLogado = auth.currentUser;
      var _idUsuarioLogado = usuarioLogado?.uid;
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("meus_items")
          .doc(_idUsuarioLogado)
          .collection("Items")
          .doc(item.id)
          .delete()
          .then((_) {
        db.collection("Items").doc(item.id).delete();
      });
      items.removeAt(index);
    }
  }

  update(Item item, Item old) {
        
    if (old.id == null) {
      viewList2();
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("meus_items")
          .doc(auth.currentUser!.uid)
          .collection("Items")
          .doc(old.id)
          .update({
        "id": old.id,
        "name": item.name,
        "amout": item.amount,
        "price": item.price,
        "active": false
      });
      
    }
     int index = items.indexOf(old);
    items[index] = item;
  }

  viewList() {
    viewList2();
    return items;
  }

  getItemName(int index) {
    return items[index].name;
  }

  getItem(int index) {
    return items[index];
  }

  getItemAmount(int index) {
    return items[index].amount;
  }

  getItemPrice(int index) {
    return items[index].price;
  }

  getItemFlag(int index) {
    return items[index].active;
  }

  setItemFlag(int index, bool flag) {
    items[index].active = flag;
  }

  cleanList(){
    items = [];
  }
}
