import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:messenger/Widgets/Picker/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File image, bool login, BuildContext context) submit;
  final bool _isLoading;
  AuthForm(this.submit, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // Helper variables
  final scaffoldKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool login = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File imageToStore;

  // Helper functions
  void _imageTobeStored(File image) {
    imageToStore = image;
  }

  void _trySubmit() {
    final bool valBool = scaffoldKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (imageToStore == null && login == false) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please select an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return null;
    }
    if (valBool) {
      scaffoldKey.currentState.save();
      widget.submit(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          imageToStore, login, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white54,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: scaffoldKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!login) UserImagePicker(_imageTobeStored),
                  TextFormField(
                    key: ValueKey('userMail'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Email not valid';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black54),
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      labelText: 'email address',
                    ),
                  ),
                  if (!login)
                    TextFormField(
                      key: ValueKey('userName'),
                      onSaved: (value) {
                        _userName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'name must be of 4 characters least';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black54),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        labelText: 'user name',
                        icon: Icon(Icons.person),
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    validator: (value) {
                      if (value.length < 7) {
                        return 'password must be of 7 characters least ';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black54),
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(Icons.remove_red_eye),
                      ),
                      labelText: 'password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              login = true;
                            });
                            if (login = true) {
                              _trySubmit();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 140,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              login = false;
                            });
                            if (login == false) {
                              _trySubmit();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 140,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
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
