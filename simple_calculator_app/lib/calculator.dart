import 'package:flutter/material.dart';


class Calculator extends StatefulWidget{
  const Calculator({super.key});

  @override 
  State<Calculator> createState() => _Calculator();

}

class _Calculator extends State<Calculator> {

  List<String> symbols = ['1','2','3','+','4','5','6','-','7','8','9','/','0','(',')','*','AC','Del', '.', '='];
    
  @override 
  Widget build(BuildContext context){
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    String expression = '0'; String result = '0';

    Widget buttons (String symbol, Color color){
      return InkWell(
        onTap: (){},
        child: Container(          
          decoration: BoxDecoration(
            color: color,
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
                    expression,
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
              height: h*0.7, width: w, padding: const EdgeInsets.all(10),              
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10
                ),
                itemCount: symbols.length,
                itemBuilder: (context, index){
                  final string = symbols[index];
                  switch(string){
                    case '+': case '-': case '/': case '*': 
                      return buttons(string, const Color.fromARGB(255, 132, 98, 59)); 
                    case '.': case '(': case ')':
                      return buttons(string, Colors.blue.shade300);
                    case 'AC':  
                      return buttons(string, Colors.red.shade700);
                    case 'Del': return buttons(string, Colors.red.shade300);
                    case '=': return buttons(string, Colors.green);
                    default: return buttons(string, Colors.white70);
                  }
                }                
              )
            ),
          )
        ]
      )
    );
  }
}

