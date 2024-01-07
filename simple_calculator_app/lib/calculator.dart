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
    final buttonFunction = ButtonFunction();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w200)), 
        centerTitle: true, backgroundColor: Colors.black26,        
      ),

      body: Column(
        children: [
          StreamBuilder<List<String>>(
            stream: buttonFunction.controller.stream,
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
                            style: TextStyle(
                              color: Colors.blueGrey.shade400, fontSize: 50, fontWeight: FontWeight.w300,
                            ),
                            maxFontSize: 50, minFontSize: 10, maxLines: 1,
                          ),
                        )
                      ),
                      Positioned(
                        right: 5, bottom: 5,
                        child: SizedBox(
                          width: w,
                          child: AutoSizeText(
                            snapshot.hasData? snapshot.data![1]: '',
                            style: TextStyle(
                              color: Colors.blueGrey.shade500, fontSize: 40, fontWeight: FontWeight.w100,
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
                  case 'AC':
                    return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: buttonFunction.deleteAll,);
                  case 'Del': 
                    return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: buttonFunction.delete);
                  case '=': 
                    return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: buttonFunction.finalResult,);
                  default: 
                    return ButtonModel(buttonColor: Colors.blue, symbol: symbol, function: () => buttonFunction.tap(symbol));
                }
              }                
            ),
          )
        ]
      )
    );
  }
}
