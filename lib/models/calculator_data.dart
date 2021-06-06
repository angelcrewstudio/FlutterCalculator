import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorData {
  String text;
  CalculatorAction action;
  Color buttonColor;
  CalculatorData(
      {this.text = "",
      this.action = CalculatorAction.OPERAND,
      this.buttonColor = Colors.black});
}

enum CalculatorAction { OPERAND, OPERATION, FUNCTION }
