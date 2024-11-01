import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String message;
  const Error({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Error',
              style: TextStyle(
                color: Colors.red,
                fontSize: 80.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Container(
              color: Colors.blue,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
