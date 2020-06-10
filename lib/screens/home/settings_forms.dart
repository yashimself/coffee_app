import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:coffee_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsFor extends StatefulWidget {
  @override
  _SettingsForState createState() => _SettingsForState();
}

class _SettingsForState extends State<SettingsFor> {
  
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

      return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData userData = snapshot.data;


            return Form(
            key: _formKey ,
            child: Column(
              children: [
                Text('Update your brew settings',
                style: TextStyle(
                  fontSize: 18.0,
                )
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20.0,),
              DropdownButtonFormField(
                value: _currentSugars ?? userData.sugar,
                decoration: textInputDecoration,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugars'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val ),
              ),
              SizedBox(height: 10.0),
              //slider
              Slider(
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                value: (_currentStrength ?? userData.strength).toDouble(),
                min: 100.0,
                max: 900.0,
                divisions: 8,
                onChanged: (val) => setState(() => _currentStrength = val.round()),
               ),

              RaisedButton(
                color: Colors.brown[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugars ?? userData.sugar,
                       _currentName ?? userData.name,
                        _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                  }
                }
              ),
              ],
            ),
          );
          }else{
            return Loading();
          }
          
        }
      );
  }
}