import 'package:flutter/material.dart';


class Calculator extends StatefulWidget{
  const Calculator({super.key});

  @override 
  State<Calculator> createState() => _Calculator();

}

class _Calculator extends State<Calculator> {

  List<String> symbols = ['1','2','3','4','5','6','7','8','9','0','.','+','-','x','/','Del','AC','(', ')', '='];

  bool isTapped = false;
  splash() {
    setState(()=> isTapped = true);
    Future.delayed(const Duration(milliseconds: 10), () =>
    setState(() => isTapped = false));
  }
  
  @override 
  Widget build(BuildContext context){    

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;    

    Widget buttons (String symbol, Color color, tap){
      return InkWell(
        onTap: tap,        
        child: Container(          
          decoration: BoxDecoration(
            color: isTapped? Colors.red : color,
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
            height: h*0.3, width: w, color: Color.fromARGB(255, 44, 43, 43)
          ),
          Expanded(
            child: Container(
              height: h*0.7, width: w, padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10
                ),
                itemCount: symbols.length,
                itemBuilder: (context, index) =>
                buttons(symbols[index], Colors.white60, splash())
              )
            ),
          )
        ]
      )
    );
  }
}

