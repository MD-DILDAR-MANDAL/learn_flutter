import 'package:flutter/material.dart';
import 'package:hello_flutter/immutable_widget.dart';
import './basic_screen.dart';
void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget{
  const StaticApp({super.key});
  
  @override
  Widget build(BuildContext context){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BasicScreen(),
      );
  }
}