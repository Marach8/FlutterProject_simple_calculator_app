import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_calculator_app/button_functions.dart';
import 'package:simple_calculator_app/button_model.dart';
import 'package:simple_calculator_app/list_of_symbols.dart';


class BasicView extends StatefulWidget{
  final AnimationController controller1, controller2;
  const BasicView({required this.controller1, required this.controller2, super.key});

  @override
  State<BasicView> createState() => _CalculatorState();
}

class _CalculatorState extends State<BasicView> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;

  @override 
  void initState(){
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
    animation = Tween(begin: 1.0, end: 0.0).chain(
      CurveTween(curve: Curves.easeInCirc)
    ).animate(controller);
  }

  @override 
  void dispose(){
    controller.dispose();
    super.dispose();
  }


  @override 
  Widget build(BuildContext context){
    var w = MediaQuery.of(context).size.width;
    final buttonFunction = ButtonFunction();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic', 
          style: TextStyle(
            color: Colors.blueGrey.shade400, 
            fontWeight: FontWeight.w300
          )
        ), 
        centerTitle: true, backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: (){
            widget.controller1.forward();
            widget.controller2.forward();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey.shade400
          )
        ),     
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
                          child: FadeTransition(
                            opacity: animation,
                            child: AutoSizeText(                        
                              snapshot.hasData ? snapshot.data![0] : '',
                              style: TextStyle(
                                color: Colors.blueGrey.shade400, 
                                fontSize: 50, fontWeight: FontWeight.w200,
                              ),
                              maxFontSize: 50, minFontSize: 10, maxLines: 1,
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        right: 5, bottom: 5,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          axisAlignment: 0.5,
                          child: SizedBox(
                            width: w,
                            child: AutoSizeText(
                              snapshot.hasData? snapshot.data![1] : '',
                              style: TextStyle(
                                color: Colors.blueGrey.shade500,
                                fontSize: 40, fontWeight: FontWeight.w100,
                              ),
                              maxFontSize: 40, minFontSize: 10, maxLines: 1,
                              textAlign: TextAlign.end,
                            ),
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
                  case '+': case '-': case '*': case '/': case '.':
                    return ButtonModel(
                      isOperator: true,
                      buttonColor: Colors.blue, 
                      symbol: symbol, 
                      function: () => buttonFunction.tap(symbol)
                    );
                  case 'AC':
                    return ButtonModel(
                      isOperator: false,
                      buttonColor: Colors.blue, 
                      symbol: symbol, 
                      function: () {
                        controller.forward().then((_) {
                          buttonFunction.deleteAll();
                          controller.reset();
                        });                        
                      },
                    );
                  case 'Del': 
                    return ButtonModel(
                      isOperator: false,
                      buttonColor: Colors.blue, 
                      symbol: symbol, 
                      function: buttonFunction.delete
                    );
                  case '=': 
                    return ButtonModel(
                      isOperator: true,
                      buttonColor: Colors.blue, 
                      symbol: symbol, 
                      function: buttonFunction.finalResult,
                    );
                  default: 
                    return ButtonModel(
                      isOperator: false,
                      buttonColor: Colors.blueGrey.shade400, 
                      symbol: symbol, 
                      function: () => buttonFunction.tap(symbol)
                    );
                }
              }                
            ),
          )
        ]
      )
    );
  }
}