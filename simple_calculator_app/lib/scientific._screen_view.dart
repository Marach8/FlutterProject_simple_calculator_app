import 'package:flutter/material.dart';

class ScientificView extends StatelessWidget {
  final AnimationController controller1, controller2;
  const ScientificView({required this.controller1, required this.controller2, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              controller1.reverse();
              controller2.reverse();
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blueGrey.shade400
            )
          )
        ], 
      ),
      body: Container(color: Colors.blue)
    );
  }
}