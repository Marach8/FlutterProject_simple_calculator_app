import 'dart:async';
import 'package:math_expressions/math_expressions.dart';

class ButtonFunction{
  static final StreamController<List<String>> _controller 
    = StreamController<List<String>>.broadcast();
  
  static final List<String> _myList = ['', '']; 
  
  StreamController<List<String>> get controller => _controller;

  void sinkData() => _controller.sink.add(_myList);

  void dispose(){
    _controller.close();
  }

  void tap(String tappedButton,){  
    _myList[0] += tappedButton;
    sinkData();
  }

  void delete(){
    final list = _myList[0];
    if (list.isNotEmpty){
      final newSubstring = list.substring(0, list.length - 1);
      _myList[0] = newSubstring;      
      sinkData();
    } return;    
  }

  void deleteAll(){
      _myList[0] = ''; 
      _myList[1] = '0';
      sinkData(); 
  }

  void finalResult(){
    try{
      Parser p = Parser();
      ContextModel contextModel = ContextModel();
      Expression exp = p.parse(_myList[0]);
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      _myList[1] = result.toString();
      _controller.sink.add(_myList);
    } catch (e) {
      _myList[1] = 'Error';
      sinkData();
    }    
  }
}