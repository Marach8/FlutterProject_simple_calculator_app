import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final Color buttonColor;
  final String symbol;
  final VoidCallback? function;
  final int index;

  const ButtonModel({
    required this.buttonColor, 
    required this.symbol,
    required this.function,
    required this.index, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Text(symbol)
    );
  }
}




//  Widget buttons (String symbol, Color color, VoidCallback function1, int index){
//     return Material(
//       child: InkWell(
//         onTap: () async{
//           setState(() => clickedButton[index] = true); function1();
//           await Future.delayed(const Duration(milliseconds:10), () => setState(() => clickedButton[index] = false));
//         },
//         child: Container(          
//           decoration: BoxDecoration(
//             color: clickedButton[index]? Colors.black: color, borderRadius: BorderRadius.circular(15),
            
//           ),
//           height: 50, width: 50, 
//           child: Center(
//             child: Text(
//               symbol,
//               style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'monospace')
//             ),
//           )
//         ),
//       ),
//     );
//   }