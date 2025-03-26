import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.red.shade500,
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Page Not Found!',
            textAlign: TextAlign.center,
            style: TextStyle(decoration: TextDecoration.none, fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
