import 'dart:async';

import 'package:math_expressions/math_expressions.dart';

class ButtonFunction{
  
  final StreamController<List<String>> _controller = StreamController<List<String>>.broadcast(); 
  List<String> myList = ['', '']; 
  //List<bool> clickedButton = List.generate(20, (_) => false);
  
  StreamController<List<String>> get controller => _controller;

  void dispose(){
    _controller.close();
  }

  tap(String a,){  
    myList[0] += a;
    _controller.sink.add(myList);
  }

  remove(String b){
    if (b.isNotEmpty){
      final data1 = b.substring(0, b.length - 1);
      myList[0] = data1;      
      _controller.sink.add(myList);
    } return;    
  }

  removeAll(String b,){
    if (b.isNotEmpty){
      myList[0] = ''; myList[1] = '0';
      _controller.sink.add(myList);
    } return;    
  }

  finalResult(String b,){
    try{
      Parser p = Parser();
      ContextModel contextModel = ContextModel();
      Expression exp = p.parse(b);
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      myList[1] = result.toString();
      _controller.sink.add(myList);
    } catch (e) {
      myList[1] = 'Error';
      _controller.sink.add(myList);
    }    
  }

  _tap(String data) => tap(data);
}