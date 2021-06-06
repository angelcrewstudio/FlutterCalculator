import 'dart:async';
import 'package:flutter_application_1/models/calculator_data.dart';

class CalculatorBloc {
  final _calculatorStreamController = StreamController<CalculatorData>();
  StreamSink<CalculatorData> get calculatorSink =>
      _calculatorStreamController.sink;
  Stream<CalculatorData> get calculatorStream =>
      _calculatorStreamController.stream;

  void dispose() {
    _calculatorStreamController.close();
  }
}
