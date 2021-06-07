import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/calculator_bloc.dart';
import 'package:flutter_application_1/models/calculator_data.dart';
import 'package:flutter_application_1/models/calculator_functions.dart';

class CalculatorDisplay extends StatefulWidget {
  CalculatorBloc bloc;
  CalculatorDisplay(this.bloc);
  @override
  _CalculatorDisplayState createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  CalculatorFunctions calcFunctions = new CalculatorFunctions();

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0))),
      child: getDisplayText(),
    );
  }

  Widget getDisplayText() {
    return StreamBuilder(
        stream: widget.bloc.calculatorStream,
        initialData:
            CalculatorData(text: "", action: CalculatorAction.FUNCTION),
        builder: (context, snapshot) {
          return Stack(
            fit: StackFit.expand,
            children: [
              getBodyText(snapshot.data as CalculatorData),
              getTitleText()
            ],
          );
        });
  }

  Widget getTitleText() {
    return Positioned(
        top: 20,
        left: 20,
        child: AnimatedDefaultTextStyle(
          style: calcFunctions.dataList.isEmpty
              ? TextStyle(fontSize: 50.0, color: Colors.white)
              : TextStyle(fontSize: 0.0, color: Colors.white),
          duration: Duration(milliseconds: 300),
          child: Text('Calculator'),
        ));
  }

  Widget getBodyText(CalculatorData data) {
    if (data.action == CalculatorAction.FUNCTION) {
      calcFunctions.executeFuntionData(data);
    } else {
      calcFunctions.addDataToList(data);
    }

    return Positioned(
        top: 20,
        right: 20,
        child: Text(getTextForStream(),
            style: TextStyle(fontSize: 50.0, color: Colors.white)));
  }

  String getTextForStream() {
    String textForStream = "";
    for (CalculatorData calData in calcFunctions.dataList) {
      textForStream += calData.text;
    }
    return textForStream;
  }
}
