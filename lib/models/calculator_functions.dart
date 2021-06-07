import 'package:flutter_application_1/models/calculator_data.dart';
import 'package:expressions/expressions.dart';

class CalculatorFunctions {
  List<CalculatorData> dataList = [];
  bool evaluated = false;

  void addDataToList(CalculatorData data) {
    if (data.action == CalculatorAction.OPERATION &&
        dataList.isNotEmpty &&
        dataList.last.action != CalculatorAction.OPERATION) {
      dataList.add(data);
      evaluated = false;
    } else if (data.action == CalculatorAction.OPERAND) {
      if (evaluated) dataList.clear();
      dataList.add(data);
      evaluated = false;
    }
  }

  void executeFuntionData(CalculatorData data) {
    switch (data.text) {
      case "AC":
        dataList.clear();
        evaluated = false;
        break;
      case "<-":
        dataList.removeLast();
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
    for (CalculatorData data in dataList) {
      dataListStr += data.text == "x" ? "*" : data.text;
    }
    var expression = Expression.parse(dataListStr);

    // Create context containing all the variables and functions used in the expression
    var context = {"": null};

    // Evaluate expression
    final evaluator = const ExpressionEvaluator();
    var r = evaluator.eval(expression, context);
    dataList.clear();
    dataList.add(
        CalculatorData(text: r.toString(), action: CalculatorAction.OPERAND));
    evaluated = true;
  }
}
