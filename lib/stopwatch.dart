import 'dart:async';
import 'package:flutter/material.dart';
import './platform_alert.dart';

class StopWatch extends StatefulWidget{
  const StopWatch({super.key,required this.name,required this.email});
  final String name;
  final String email;

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>{
  
  bool isTicking = false;
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  @override

  void _onTick(Timer time){
    if(mounted){
      setState((){
        milliseconds += 100;
      });
    } 
  }
  Widget _buildLapDisplay(){
    return Scrollbar(
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index){
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50),
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondsText(milliseconds)),
          );
        }        
      ),
    );
  }
  @override
  void dispose(){
    timer.cancel();
    scrollController.dispose();
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

    final totalRuntime = laps.fold(milliseconds,(total,lap) => total+lap);
    final alert = PlatformAlert(
      title: 'Run completed',
      message: 'Total Run Time is ${_secondsText(totalRuntime)}.'
    );
    alert.show(context);
  }

  void _lap(){
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
    scrollController.animateTo(
      itemHeight*laps.length,
      duration: Duration(milliseconds:500), 
      curve: Curves.easeIn,
      );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title:Text(widget.name),
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