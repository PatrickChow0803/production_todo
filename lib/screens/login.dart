import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:product_to_do/services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Login({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const ValueKey("username"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Email"),
                  controller: _emailController,
                ),
                TextFormField(
                  key: const ValueKey("password"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  obscureText: true,
                  // validator: (val) => val.length < 6 ? 'Password too short.' : null,
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  key: const ValueKey("signIn"),
                  onPressed: () async {
                    final String returnVal = await Auth(auth: widget.auth).signIn(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (returnVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(returnVal),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text("Sign In"),
                ),
                FlatButton(
                  key: const ValueKey("createAccount"),
                  onPressed: () async {
                    final String returnVal = await Auth(auth: widget.auth).createAccount(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (returnVal == "Success") {
                      _emailController.clear();
                      _passwordController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(returnVal),
                        duration: const Duration(seconds: 2),
                      ));
                    }
                  },
                  child: const Text("Create Account"),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
