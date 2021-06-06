import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/calculator_actions.dart';
import 'package:flutter_application_1/models/calculator_bloc.dart';
import 'components/calculator_display.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  CalculatorBloc _bloc = new CalculatorBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Flexible(flex: 1, child: CalculatorDisplay(_bloc)),
            Flexible(flex: 2, child: CalculatorActions(_bloc)),
          ]),
        ),
      ),
    );
  }
}
