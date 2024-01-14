import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final Color buttonColor;
  final String symbol;
  final VoidCallback? function;
  final bool isOperator;

  const ButtonModel({
    required this.isOperator,
    required this.buttonColor, 
    required this.symbol,
    required this.function,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: isOperator ? 40 : 30, color: buttonColor, 
            fontWeight: isOperator? FontWeight.w200 : FontWeight.w100
          )
        ),
      )
    );
  }
}