import 'package:flutter/material.dart';
import 'package:master_plan/views/plan_creator_screen.dart';
import './plan_provider.dart';
import './models/plan.dart';

void main() {
  runApp(const MasterPlanApp());
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build (BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>(const []),
      child: MaterialApp(
        title: 'State management App',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.purple,
          ),
        home:  const PlanCreatorScreen(),
      ),
    );
  }
}