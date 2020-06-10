import 'package:coffee_app/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_app/screens/home/brew_tile.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context);
    //print(brews);

    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugar);
     // print(brew.strength);
    });

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index){
      return BrewTile(brew: brews[index]);
   },
    );
   
  }
}