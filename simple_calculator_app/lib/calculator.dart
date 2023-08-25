import 'dart:async';

import 'package:flutter/material.dart';


class Calculator extends StatefulWidget{
  const Calculator({super.key});

  @override 
  State<Calculator> createState() => _Calculator();

}

class _Calculator extends State<Calculator> {

  List<String> symbols = ['1','2','3','+','4','5','6','-','7','8','9','/','0','(',')','*','AC','Del', '.', '='];
  final StreamController<String> _controller = StreamController<String>();  

  @override 
  void dispose(){
    _controller.close();
    super.dispose();
  }


  bool isTapped = false;
  String expression = '';

  tap(String data){
    setState(() => isTapped = true);
    Future.delayed(const Duration(milliseconds:10), () => setState(() => isTapped = false));
    expression += data;
    _controller.sink.add(expression);
  }

  remove(data){
    if (data.isNotEmpty){
      final data1 = data.substring(0, data.length - 1);
      _controller.sink.add(data1);
      expression = data1;
    } return;    
  }

  removeAll(data){
    if (data.isNotEmpty){
      const data1 = '';
      _controller.sink.add(data1);
      expression = '';
    } return;    
  }

  _tap(String data) => tap(data);
  // _remove(String data) => remove(data);
  // _removeAll(String data) => removeAll(data);


  Widget buttons (String symbol, Color color, VoidCallback function){
    return InkWell(
      onTap: function,
      child: Container(          
        decoration: BoxDecoration(
          color: isTapped ? Colors.yellow : color,
          borderRadius: BorderRadius.circular(15)
        ),
        height: 50, width: 50, 
        child: Center(
          child: Text(
            symbol,
            style: const TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,
              fontFamily: 'monospace'
            )
          ),
        )
      ),
    );
  }

  @override 
  Widget build(BuildContext context){
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    String result = '0'; 


    return StreamBuilder<String>(
      stream: _controller.stream,
      builder: (context, snapshot) {         
        return Scaffold(
          appBar: AppBar(
            title: const Text('Simple Calculator'), 
            centerTitle: true, backgroundColor: Colors.deepPurpleAccent,        
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
                        snapshot.hasData? snapshot.data.toString(): '',
                        style: const TextStyle(
                          color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold,
                          fontFamily: 'monospace'
                        )
                      )
                    ),
                    Positioned(
                      right: 5, bottom: 5,
                      child: Text(
                        result,
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
                          return buttons(string, const Color.fromARGB(255, 132, 98, 59), () => _tap(string)); 
                        case '.': case '(': case ')':
                          return buttons(string, Colors.blue.shade300, () => _tap(string));
                        case 'AC':  
                          return buttons(string, Colors.red.shade700, () => removeAll(string));
                        case 'Del': return buttons(string, Colors.red.shade300, () => remove(snapshot.data.toString()));
                        case '=': return buttons(string, Colors.green, () => _tap(string));
                        default: return buttons(string, Colors.white70, () => _tap(string));
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

