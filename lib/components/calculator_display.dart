import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/calculator_bloc.dart';
import 'package:flutter_application_1/models/calculator_data.dart';
import 'package:expressions/expressions.dart';

class CalculatorDisplay extends StatefulWidget {
  CalculatorBloc bloc;
  CalculatorDisplay(this.bloc);
  @override
  _CalculatorDisplayState createState() => _CalculatorDisplayState();
}

class _CalculatorDisplayState extends State<CalculatorDisplay> {
  List<CalculatorData> _dataList = [];
  bool evaluated = false;

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
        top: 5,
        left: 15,
        child: AnimatedDefaultTextStyle(
          style: _dataList.isEmpty
              ? TextStyle(fontSize: 50.0, color: Colors.white)
              : TextStyle(fontSize: 0.0, color: Colors.white),
          duration: Duration(milliseconds: 300),
          child: Text('Calculator'),
        ));
  }

  Widget getBodyText(CalculatorData data) {
    if (data.action == CalculatorAction.FUNCTION) {
      executeFuntionData(data);
    } else {
      addDataToList(data);
    }

    return Positioned(
        top: 5,
        right: 15,
        child: Text(getTextForStream(),
            style: TextStyle(fontSize: 50.0, color: Colors.white)));
  }

  void addDataToList(CalculatorData data) {
    if ((data.action == CalculatorAction.OPERATION &&
            _dataList.isNotEmpty &&
            _dataList.last.action != CalculatorAction.OPERATION) ||
        (data.action == CalculatorAction.OPERAND)) {
      if (evaluated) _dataList.clear();
      _dataList.add(data);
      evaluated = false;
    }
  }

  void executeFuntionData(CalculatorData data) {
    switch (data.text) {
      case "AC":
        _dataList.clear();
        evaluated = false;
        break;
      case "<-":
        _dataList.removeLast();
        evaluated = false;
        break;
      case "=":
        evaluate();
        break;
      default:
        // do nothing
        break;
    }
  }

  void evaluate() {
    String dataListStr = "";
    for (CalculatorData data in _dataList) {
      dataListStr += data.text == "x" ? "*" : data.text;
    }
    var expression = Expression.parse(dataListStr);

    // Create context containing all the variables and functions used in the expression
    var context = {"": null};

    // Evaluate expression
    final evaluator = const ExpressionEvaluator();
    var r = evaluator.eval(expression, context);
    _dataList.clear();
    _dataList.add(
        CalculatorData(text: r.toString(), action: CalculatorAction.OPERAND));
    evaluated = true;
  }

  String getTextForStream() {
    String textForStream = "";
    for (CalculatorData calData in _dataList) {
      textForStream += calData.text;
    }
    return textForStream;
  }
}
