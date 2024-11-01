import 'package:flutter/material.dart';
import 'error.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int length;
  final TextEditingController lengthController = TextEditingController();
  late dynamic complexity;
  final List<Widget> iosComplexities = [
    const Text("Easy"),
    const Text("Medium"),
    const Text("Hard"),
    const Text("Impossible"),
  ];
  final List<DropdownMenuEntry<dynamic>> otherOSComplexities = [
    const DropdownMenuEntry(
      label: "Easy",
      value: "Easy",
    ),
    const DropdownMenuEntry(
      label: "Medium",
      value: "Medium",
    ),
    const DropdownMenuEntry(
      label: "Hard",
      value: "Hard",
    ),
    const DropdownMenuEntry(
      label: "Impossible",
      value: "Impossible",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Password Generator",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: lengthController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      try {
                        length = int.parse(val);
                      } catch (e) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Error(
                              message: "Please enter a number for the length",
                            ),
                          ),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Length of Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Platform.isIOS
                      ? CupertinoPicker(
                          itemExtent: double.infinity,
                          onSelectedItemChanged: (val) {
                            complexity = val;
                          },
                          children: iosComplexities,
                        )
                      : DropdownMenu(
                          dropdownMenuEntries: otherOSComplexities,
                          onSelected: (val) {
                            complexity = val;
                          },
                        ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Builder(
                    builder: (context) {
                      return MaterialButton(
                        onPressed: () {
                          lengthController.text = "";
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PasswordScreen(
                                complexity: complexity,
                                length: length,
                              );
                            },
                          );
                        },
                        elevation: 7.3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.blue,
                        child: const Text(
                          "Get password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
