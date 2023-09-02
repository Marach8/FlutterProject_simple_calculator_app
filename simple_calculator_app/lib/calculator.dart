import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class Calculator extends StatefulWidget{
  const Calculator({super.key});

  @override 
  State<Calculator> createState() => _Calculator();

}

class _Calculator extends State<Calculator> {

  List<String> symbols = ['1','2','3','+','4','5','6','-','7','8','9','/','0','(',')','*','AC','Del', '.', '='];
  final StreamController<List<String>> _controller = StreamController<List<String>>.broadcast(); 
  List<String> myList = ['', '']; List<bool> clickedButton = List.generate(20, (_) => false);
  

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

  _tap(String data,) => tap(data);

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
                      child: Text(                        
                        snapshot.hasData ? snapshot.data![0]: '',
                        style: const TextStyle(
                          color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold,
                          fontFamily: 'monospace'
                        )
                      )
                    ),
                    Positioned(
                      right: 5, bottom: 5,
                      child: Text(
                        snapshot.hasData? snapshot.data![1]: '',
                        style: const TextStyle(
                          color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold,
                          fontFamily: 'monospace'
                        )
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
                    itemCount: symbols.length,
                    itemBuilder: (context, index){
                      final string = symbols[index];                     
                      switch(string){
                        case '+': case '-': case '/': case '*': 
                          return buttons(string, const Color.fromARGB(255, 132, 98, 59), () => _tap(string), index); 
                        case '.': case '(': case ')': 
                          return buttons(string, Colors.blue.shade300, () => _tap(string), index);
                        case 'AC':
                          return buttons(string, Colors.red.shade700, () => removeAll(snapshot.data![0]), index);
                        case 'Del': 
                          return buttons(string, Colors.red.shade300, () => remove(snapshot.data![0]), index);
                        case '=': 
                          return buttons(string, Colors.green, () => finalResult(snapshot.data![0]), index);
                        default: return buttons(string, Colors.white70, () => _tap(string), index);
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
