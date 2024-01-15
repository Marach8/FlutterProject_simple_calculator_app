import 'dart:async';
import 'package:math_expressions/math_expressions.dart';

class ButtonFunction{
  
  final StreamController<List<String>> _controller = StreamController<List<String>>.broadcast();
  
  List<String> myList = ['', '']; 
  
  StreamController<List<String>> get controller => _controller;

  void dispose(){
    _controller.close();
  }

  void tap(String tappedButton,){  
    myList[0] += tappedButton;
    _controller.sink.add(myList);
  }

  void delete(){
    final list = myList[0];
    if (list.isNotEmpty){
      final newSubstring = list.substring(0, list.length - 1);
      myList[0] = newSubstring;      
      _controller.sink.add(myList);
    } return;    
  }

  void deleteAll(){
      myList[0] = ''; 
      myList[1] = '0';
      _controller.sink.add(myList); 
  }

  void finalResult(){
    try{
      Parser p = Parser();
      ContextModel contextModel = ContextModel();
      Expression exp = p.parse(myList[0]);
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      myList[1] = result.toString();
      _controller.sink.add(myList);
    } catch (e) {
      myList[1] = 'Error';
      _controller.sink.add(myList);
    }    
  }

  Stream<int> getNumbers() 
    => Stream.periodic(const Duration(milliseconds: 50), (i) => i).take(10);
}