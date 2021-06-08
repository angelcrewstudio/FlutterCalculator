import 'package:flutter_application_1/models/calculator_data.dart';
import 'package:expressions/expressions.dart';

class CalculatorFunctions {
  List<CalculatorData> dataList = [];
  bool evaluated = false;
  bool errorOccured = false;
  void addDataToList(CalculatorData data) {
    if (data.action == CalculatorAction.OPERATION &&
        dataList.isNotEmpty &&
        dataList.last.action != CalculatorAction.OPERATION &&
        !errorOccured) {
      dataList.add(data);
      evaluated = false;
    } else if (data.action == CalculatorAction.OPERAND) {
      if (evaluated) clearDataList();
      dataList.add(data);
    }
  }

  void clearDataList() {
    dataList.clear();
    evaluated = false;
    errorOccured = false;
  }

  void executeFuntionData(CalculatorData data) {
    switch (data.text) {
      case "AC":
        clearDataList();
        break;
      case "<-":
        dataList.removeLast();
        evaluated = false;
        errorOccured = false;
        break;
      case "=":
        evaluateDataList();
        break;
      default:
        // do nothing
        break;
    }
  }

  dynamic evaluate() {
    String dataListStr = "";
    for (CalculatorData data in dataList) {
      dataListStr += data.text == "x" ? "*" : data.text;
    }
    var result;
    try {
      var expression = Expression.parse(dataListStr);

      // Create context containing all the variables and functions used in the expression
      var context = {"": null};

      // Evaluate expression
      final evaluator = const ExpressionEvaluator();
      result = evaluator.eval(expression, context);
      if (!isInteger(result)) {
        result = double.parse((result).toStringAsFixed(2));
      }
    } catch (e) {
      result = "Error!";
      errorOccured = true;
    }

    return result;
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  void evaluateDataList() {
    var r = evaluate();
    dataList.clear();
    dataList.add(
        CalculatorData(text: r.toString(), action: CalculatorAction.OPERAND));
    evaluated = true;
  }
}
