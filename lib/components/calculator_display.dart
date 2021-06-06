import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/calculator_bloc.dart';
import 'package:flutter_application_1/models/calculator_data.dart';

class CalculatorDisplay extends StatefulWidget {
  CalculatorBloc bloc;
  CalculatorDisplay(this.bloc);
  @override
  _CalculatorDisplayState createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  List<CalculatorData> _dataList = [];

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
      child: Stack(
        fit: StackFit.expand,
        children: [getTitleText(), getBodyText()],
      ),
    );
  }

  Widget getTitleText() {
    return Positioned(
        top: 5,
        left: 15,
        child: Text('Calculator',
            style: TextStyle(fontSize: 50.0, color: Colors.white)));
  }

  Widget getBodyText() {
    return StreamBuilder(
      stream: widget.bloc.calculatorStream,
      initialData: CalculatorData(text: "", action: CalculatorAction.FUNCTION),
      builder: (context, snapshot) {
        CalculatorData data = snapshot.data as CalculatorData;
        if (data.action == CalculatorAction.OPERAND ||
            data.action == CalculatorAction.OPERATION) {
          _dataList.add(data);
        } else {
          executeFuntionData(data);
        }

        return Positioned(
            bottom: 5,
            right: 15,
            child: Text(getTextForStream(),
                style: TextStyle(fontSize: 50.0, color: Colors.white)));
      },
    );
  }

  void executeFuntionData(CalculatorData data) {
    switch (data.text) {
      case "AC":
        _dataList.clear();
        break;
      case "<-":
        _dataList.removeLast();
        break;
      case "=":
        // Show result
        break;
      case "<>":
        // Move To Scientific calculator
        break;
    }
  }

  String getTextForStream() {
    String textForStream = "";
    for (CalculatorData calData in _dataList) {
      textForStream += calData.text;
    }
    return textForStream;
  }
}
