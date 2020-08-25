import 'package:e_school/models/brew.dart';
import 'package:e_school/screens/home/settings_form.dart';
import 'package:e_school/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:e_school/services/database.dart';
import 'package:provider/provider.dart';
import 'package:e_school/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  //creating an instance of AuthService
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('E-School'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings')),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
