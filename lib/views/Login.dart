import 'package:flutter/material.dart';
import 'package:project/models/User.dart';
import 'package:project/views/widgets/ButtonCustom.dart';
import 'package:project/views/widgets/InputCustom.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail =
      TextEditingController(text: "admin@admin.com");
  final TextEditingController _controllerPassword =
      TextEditingController(text: "123456");
  bool _create = false;
  String _errorMessage = "";
  String _textButton = "Entrar";

  _createUser(User user) {
    //TODO: Create user
    Navigator.pushReplacementNamed(context, "/lista-compras");
  }

  _loginUser(User user) {
    //TODO: Login user
    Navigator.pushReplacementNamed(context, "/lista-compras");
  }

  _validateFields() {
    //TODO: create controller login
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isNotEmpty && email.contains("@") && email.contains(".")) {
      if (password.isNotEmpty && password.length >= 6) {
        User user = User();
        user.email = email;
        user.password = password;

        if (_create) {
          _createUser(user);
          setState(() {
            _errorMessage = "";
          });
        } else {
          _loginUser(user);
          setState(() {
            _errorMessage = "";
          });
        }
      } else {
        setState(() {
          _errorMessage = "Preencha a senha! digite mais de 6 caracteres.";
        });
      }
    } else {
      setState(() {
        _errorMessage = "Preencha o E-mail válido.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Image.asset(
                "images/LoginImage.png",
                width: 200,
                height: 150,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: InputCustom(
                controller: _controllerEmail,
                hintText: "E-mail",
                autofocus: true,
                textInputType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: InputCustom(
                controller: _controllerPassword,
                hintText: "Senha",
                obscureText: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Logar"),
                Switch(
                    value: _create,
                    onChanged: (bool value) {
                      setState(() {
                        _create = value;
                        _textButton = "Entrar";
                        if (_create) {
                          _textButton = "Cadastrar";
                        }
                      });
                    }),
                Text("Cadastrar"),
              ],
            ),
            ButtonCustom(
                text: _textButton,
                onPressed: () {
                  _validateFields();
                }),
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
        ))),
      ),
    );
  }
}
