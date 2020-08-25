import 'package:e_school/services/auth.dart';
import 'package:e_school/shared/constants.dart';
import 'package:e_school/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //creating a function and constructor parameter in the widget itself

  final Function toggleView;

  //passing a parameter and setting it equal to toggleView
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //creating an object and instace of AuthService class from the auth.dart file
  //using it in onpress of signin
  final AuthService _auth = AuthService();
  //Global key
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text feild state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Sign in to School'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    //calling the widget function
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a Password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Could not SignIn with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Expanded(
                      child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

// RaisedButton(
//           child: Text('Sign in Anon'),
//           onPressed: () async {
//onpressing this we want to access auth.dart file
//and the signInAnon function from the auth service class
//setting auth.signInAnon to a dynamic result
//             dynamic result = await _auth.signInAnon();
//             if (result == null) {
//               print('error signing in');
//             } else {
//               print('Signin');
//               print(result.uid);
//             }
//           },
//         ),
