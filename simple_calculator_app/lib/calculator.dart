import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_calculator_app/button_model.dart';
import 'package:simple_calculator_app/list_of_symbols.dart';


class Calculator extends StatefulWidget{
  const Calculator({super.key});

  @override 
  State<Calculator> createState() => _Calculator();

}

class _Calculator extends State<Calculator> {

 
  final StreamController<List<String>> _controller = StreamController<List<String>>.broadcast(); 
  List<String> myList = ['', '']; 
  List<bool> clickedButton = List.generate(20, (_) => false);
  

  @override 
  void dispose(){
    _controller.close();
    super.dispose();
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

  Widget buttons (String symbol, Color color, VoidCallback function1, int index){
    return Material(
      child: InkWell(
        onTap: () async{
          setState(() => clickedButton[index] = true); function1();
          await Future.delayed(const Duration(milliseconds:10), () => setState(() => clickedButton[index] = false));
        },
        child: Container(          
          decoration: BoxDecoration(
            color: clickedButton[index]? Colors.black: color, borderRadius: BorderRadius.circular(15),
            
          ),
          height: 50, width: 50, 
          child: Center(
            child: Text(
              symbol,
              style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'monospace')
            ),
          )
        ),
      ),
    );
  }

  @override 
  Widget build(BuildContext context){
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;  


    return StreamBuilder<List<String>?>(
      stream: _controller.stream,
      builder: (context, snapshot) {         
        return Scaffold(
          appBar: AppBar(
            title: const Text('Simple Calculator'), 
            centerTitle: true, backgroundColor: Colors.white10,        
          ),
          body: Column(
            children: [
              Container(
                height: h*0.3, width: w, color: const Color.fromARGB(255, 84, 83, 83),
                child: Stack(
                  children: [
                    Positioned(
                      left: 5, top: 5,
                      child: SizedBox(
                        width: w,
                        child: AutoSizeText(                        
                          snapshot.hasData ? snapshot.data![0]: '',
                          style: const TextStyle(
                            color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold,
                            fontFamily: 'monospace'
                          ),
                          maxFontSize: 40, minFontSize: 10, maxLines: 1,
                        ),
                      )
                    ),
                    Positioned(
                      right: 5, bottom: 5,
                      child: SizedBox(
                        width: w,
                        child: AutoSizeText(
                          snapshot.hasData? snapshot.data![1]: '',
                          style: const TextStyle(
                            color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold,
                            fontFamily: 'monospace'
                          ),
                          maxFontSize: 40, minFontSize: 10, maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                      )
                    ),
                  ],
                )
              ),
              Expanded(
                child: Container(                         
                  padding: const EdgeInsets.all(10),              
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, 
                    ),
                    itemCount: listOfSymbols.length,
                    itemBuilder: (context, index){
                      final symbol = listOfSymbols.elementAt(index);
                      switch(symbol){
                        case '+': case '-': case '/': case '*': 
                          return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                        case '.': case '(': case ')': 
                          return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                        case 'AC':
                          return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                        case 'Del': 
                          return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                        case '=': 
                          return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                        default: return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: (){}, index: index);
                      }
                    }                
                  )
                ),
              )
            ]
          )
        );
      }
    );
  }
}
