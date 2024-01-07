import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_calculator_app/button_functions.dart';
import 'package:simple_calculator_app/button_model.dart';
import 'package:simple_calculator_app/list_of_symbols.dart';


class Calculator extends StatelessWidget{
  const Calculator({super.key});

  @override 
  Widget build(BuildContext context){
    var w = MediaQuery.of(context).size.width;
    final ButtonFunction buttonFunc = ButtonFunction();

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator', style: TextStyle(color: Colors.blueGrey.shade500)), 
        centerTitle: true, backgroundColor: Colors.black26,        
      ),
      body: Column(
        children: [
          StreamBuilder<List<String>>(
            stream: buttonFunc.controller.stream,
            builder: (context, snapshot) {
              return Expanded(
                flex: 2,
                child: Container(
                color: Colors.black26,
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
              );
            }
          ),

          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
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
            ),
          )
        ]
      )
    );
  }
}
