import 'package:flutter/material.dart';
import '../Widgets/Auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.shopify.com/s/files/1/0027/8645/9757/products/Cloud2021_1800x1800.jpg'))),
          ),
          AuthForm(),
        ],
      ),
    );
  }
}
