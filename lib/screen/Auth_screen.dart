import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/Auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  void _submit(String email, String password, String userName, bool log,
      BuildContext ctx) async {
    UserCredential _userCredential;
    try {
      if (log == true) {
        setState(() {
          isLoading = true;
        });
        _userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        setState(() {
          isLoading = true;
        });
        _userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        FirebaseFirestore.instance
            .collection('Users')
            .doc(_userCredential.user.uid)
            .set({
          'username': userName,
          'Email': email,
        });
      }
    } on PlatformException catch (error) {
      setState(() {
        isLoading = false;
      });
      var message = 'an Error occurred please check your credentials';
      if (error.message != null) {
        message = error.message;
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(error.message),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      'https://cdn.shopify.com/s/files/1/0027/8645/9757/products/Cloud2021_1800x1800.jpg',
                    ))),
          ),
          AuthForm(_submit, isLoading),
        ],
      ),
    );
  }
}
