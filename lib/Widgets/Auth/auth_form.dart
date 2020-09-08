import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final scaffoldKey = GlobalKey<FormState>();
  bool ob = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: scaffoldKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: 'email address',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'user name',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    obscureText: ob,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            ob = !ob;
                          });
                        },
                        child: Icon(Icons.remove_red_eye),
                      ),
                      labelText: 'password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    textColor: Colors.white60,
                    color: Theme.of(context).primaryColor,
                    mouseCursor: MouseCursor.uncontrolled,
                    child: Text('Login'),
                    onPressed: () {},
                  ),
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_add,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text('create an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
