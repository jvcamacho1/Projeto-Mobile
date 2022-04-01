import 'package:flutter/material.dart';
import 'package:project/RouteGenerator.dart';
import 'package:project/views/Login.dart';
import 'package:project/views/ShoppingList.dart';

void main() => runApp(MaterialApp(
  title: "Lista de compras",
  home: Login(),
  initialRoute: "/login",
  onGenerateRoute: RouteGenerator.generateRoute,
  debugShowCheckedModeBanner: false,
));