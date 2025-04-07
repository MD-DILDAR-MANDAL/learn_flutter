import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget{
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>{
  
  bool isTicking = false;
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];

  @override

  void _onTick(Timer time){
    if(mounted){
      setState((){
        milliseconds += 100;
      });
    } 
  }
  Widget _buildLapDisplay(){
    return ListView(
      children: [
        for(int milliseconds in laps)
          ListTile(
            title: Text(_secondsText(milliseconds)),
          ),
      ],
    );
  }
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }
  
  String _secondsText(int milliseconds){
    final seconds = milliseconds/1000;
    return '$seconds seconds';
  }

  void _startTimer(){
    timer  = Timer.periodic(Duration(milliseconds: 100),_onTick);
    setState(() {
      milliseconds = 0;
      isTicking = true;
      laps.clear();
    });
  }
  void _stopTimer(){
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  void _lap(){
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
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
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20,),
          _buildControls()
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
                onPressed:isTicking 
                ? null
                : _startTimer,
                child: const Text('start'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: isTicking ? _lap : null,
                child: const Text('Lap'),
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
        );
  }
}