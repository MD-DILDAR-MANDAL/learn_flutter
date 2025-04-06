import 'package:flutter/material.dart';

class DeepTree extends StatelessWidget {
  const DeepTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  FlutterLogo(),
                  Text('flutter is amazing.'),
                ],
              ),
              Expanded(child: Container(
                color: Colors.purple,
              ),
              ),
              Text('its all widgets'),
              Text('Let\'s find out how deep the rabbit hole goes.')
            ],
          )
        ),
      ),
    );
  }
}