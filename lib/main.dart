import 'package:flutter/material.dart';
import 'package:learn_flutter/e_commerce_screen_after.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green,
          elevation: 10,
          titleTextStyle: TextStyle(
              fontFamily: 'LeckerliOne',
              fontSize: 24,
            
            ),
          ),
      ),
      home: ECommerceScreen(),
    );
  }
}