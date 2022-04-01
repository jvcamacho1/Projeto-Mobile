import 'package:project/models/Item.dart';

class ItemsController{

  ItemsController();

  static List<Item> items = [];

  init(){
    Item defaultItem = Item();
    defaultItem.name = "Banana";
    defaultItem.amount = 5;
    defaultItem.price = 1;
    items.add(defaultItem);
  }
  add(Item item) async {
    items.add(item);
  }

  remove(int index) async {
    items.removeAt(index);
  }

  update(Item item) async {
    int index = items.indexOf(item);
    items[index] = item;
  }

  viewList(){
    return items;
  }

  getItemName(int index){
    return items[index].name;
  }
  getItemAmount(int index){
    return items[index].amount;
  }
  getItemPrice(int index){
    return items[index].price;
  }
}