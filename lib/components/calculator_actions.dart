import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/calculator_buttons.dart';
import 'package:flutter_application_1/models/calculator_bloc.dart';
import 'package:flutter_application_1/utils/grid_view.dart';
import '../models/calculator_data.dart';

class CalculatorActions extends StatefulWidget {
  CalculatorBloc bloc;
  CalculatorActions(this.bloc);

  @override
  _CalculatorActionsState createState() => _CalculatorActionsState();
}

class _CalculatorActionsState extends State<CalculatorActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: buildtableView(),
    );
  }

  Widget buildtableView() {
    return CustomGridView(
        columnCount: 4,
        children: getNormalCalculatorButtons().map((data) {
          return CalculatorButtons(data: data, callback: onButtonPressed);
        }));
  }

  void onButtonPressed(CalculatorData data) {
    widget.bloc.calculatorSink.add(data);
  }

  List<CalculatorData> getNormalCalculatorButtons() {
    return [
      CalculatorData(text: "AC", action: CalculatorAction.FUNCTION),
      CalculatorData(text: "<-", action: CalculatorAction.FUNCTION),
      CalculatorData(text: "%", action: CalculatorAction.OPERATION),
      CalculatorData(
          text: "/",
          action: CalculatorAction.OPERATION,
          buttonColor: Colors.grey.shade900),
      CalculatorData(text: "7", action: CalculatorAction.OPERAND),
      CalculatorData(text: "8", action: CalculatorAction.OPERAND),
      CalculatorData(text: "9", action: CalculatorAction.OPERAND),
      CalculatorData(
          text: "x",
          action: CalculatorAction.OPERATION,
          buttonColor: Colors.grey.shade900),
      CalculatorData(text: "4", action: CalculatorAction.OPERAND),
      CalculatorData(text: "5", action: CalculatorAction.OPERAND),
      CalculatorData(text: "6", action: CalculatorAction.OPERAND),
      CalculatorData(
          text: "-",
          action: CalculatorAction.OPERATION,
          buttonColor: Colors.grey.shade900),
      CalculatorData(text: "1", action: CalculatorAction.OPERAND),
      CalculatorData(text: "2", action: CalculatorAction.OPERAND),
      CalculatorData(text: "3", action: CalculatorAction.OPERAND),
      CalculatorData(
          text: "+",
          action: CalculatorAction.OPERATION,
          buttonColor: Colors.grey.shade900),
      CalculatorData(text: " ", action: CalculatorAction.FUNCTION),
      CalculatorData(text: "0", action: CalculatorAction.OPERAND),
      CalculatorData(text: " ", action: CalculatorAction.FUNCTION),
      CalculatorData(
          text: "=",
          action: CalculatorAction.FUNCTION,
          buttonColor: Colors.red.shade700)
    ];
  }
}
