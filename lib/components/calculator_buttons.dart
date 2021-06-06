import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/calculator_data.dart';

class CalculatorButtons extends StatelessWidget {
  CalculatorData data;
  Function(CalculatorData) callback;

  CalculatorButtons({required this.data, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7.8,
      padding: EdgeInsets.all(5),
      child: TextButton(
          onPressed: () => callback(data),
          child: Text(
            data.text,
            style: TextStyle(fontSize: 30),
          ),
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: data.buttonColor,
              shape: CircleBorder())),
    );
  }
}
