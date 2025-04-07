import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget{
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>{
  
  bool isTicking = false;
  int seconds = 0;
  late Timer timer;
  @override

  void _onTick(Timer time){
    if(mounted){
      setState((){
        ++seconds;
      });
    } 
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }
  
  String _secondsText() => seconds == 1? 'second':'seconds';
  void _startTimer(){
    timer  = Timer.periodic(Duration(seconds: 1),_onTick);
    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }
  void _stopTimer(){
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title:const Text('Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                  onPressed:isTicking 
                  ? null
                  : _startTimer,
                  child: const Text('start'),
                ),
                const SizedBox(width: 20),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed:isTicking 
                  ? _stopTimer 
                  :null,
                  child: const Text('stop'),
              ),
            ],
          )
        ],
      ),
    );
  }
}