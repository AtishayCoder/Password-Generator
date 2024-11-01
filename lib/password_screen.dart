import 'package:flutter/material.dart';
import 'choices.dart';
import 'dart:io' show Platform;
import 'dart:math';

class PasswordScreen extends StatefulWidget {
  final dynamic complexity;
  final int length;

  const PasswordScreen(
      {super.key, required this.complexity, required this.length});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String password = "";
  List passwordComponents = [];
  String complexityThis = "";
  final random = Random();

  void getPassword() {
    getPasswordComponents();
    final random = Random();

    for (var i = 0; i < widget.length; i++) {
      var characterType = passwordComponents[random.nextInt(passwordComponents.length)];
      if (characterType == "Letter") {
        var val = random.nextBool() ? 0 : 1;
        // Capital
        if (val == 0) {
          var letter = random.nextInt(PasswordChoices.capitalLetters.length);
          password += PasswordChoices.capitalLetters[letter];
        }
        // Small
        else if (val == 1) {
          var letter = random.nextInt(PasswordChoices.smallLetters.length);
          password += PasswordChoices.smallLetters[letter];
        }
      } else if (characterType == "Number") {
        var number = random.nextInt(PasswordChoices.numbers.length);
        password += PasswordChoices.numbers[number];
      } else if (characterType == "Symbol") {
        var symbol = random.nextInt(PasswordChoices.symbols.length);
        password += PasswordChoices.symbols[symbol];
      } else if (characterType == "Impossible") {
        var impossible = random.nextInt(PasswordChoices.impossible.length);
        password += PasswordChoices.impossible[impossible];
      }
    }
  }


  // void getPassword() {
  //   getPasswordComponents();
  //   for (var i=0; i<widget.length; i++) {
  //     var characterType = passwordComponents[random.nextInt(passwordComponents.length)];
  //     if (characterType == "Letter") {
  //       var val = random.nextInt(2);
  //       // Capital
  //       if (val == 0) {
  //         var letter = random.nextInt(PasswordChoices.capitalLetters.length);
  //         password += PasswordChoices.capitalLetters[letter];
  //       }
  //     //   Small
  //       else if (val == 1) {
  //         var letter = random.nextInt(PasswordChoices.smallLetters.length);
  //         password += PasswordChoices.smallLetters[letter];
  //       }
  //     } else if (characterType == "Number") {
  //       var number = random.nextInt(PasswordChoices.numbers.length);
  //       password += PasswordChoices.numbers[number];
  //     } else if (characterType == "Symbol") {
  //       var symbol = random.nextInt(PasswordChoices.symbols.length);
  //       password += PasswordChoices.symbols[symbol];
  //     } else if (characterType == "Impossible") {
  //       var impossible = random.nextInt(PasswordChoices.impossible.length);
  //       password += PasswordChoices.impossible[impossible];
  //     }
  //   }
  // }
  void getPasswordComponents() {
    if (Platform.isIOS) {
      convert();
      if (complexityThis == "Easy") {
        passwordComponents = ["Letter"];
      } else if (complexityThis == "Medium") {
        passwordComponents = ["Letter", "Number"];
      } else if (complexityThis == "Hard") {
        passwordComponents = ["Letter", "Number", "Symbol"];
      } else if (complexityThis == "Impossible") {
        passwordComponents = ["Letter", "Number", "Symbol", "Impossible"];
      } else {
        passwordComponents = ["Letter", "Number", "Symbol", "Impossible"];
      }
    } else {
      if (widget.complexity == "Easy") {
        passwordComponents = ["Letter"];
      } else if (widget.complexity == "Medium") {
        passwordComponents = ["Letter", "Number"];
      } else if (widget.complexity == "Hard") {
        passwordComponents = ["Letter", "Number", "Symbol"];
      } else if (widget.complexity == "Impossible") {
        passwordComponents = ["Letter", "Number", "Symbol", "Impossible"];
      } else {
        passwordComponents = ["Letter", "Number", "Symbol", "Impossible"];
      }
    }
  }

  void convert() {
    if (widget.complexity.runtimeType == int) {
      if (widget.complexity == 0) {
        complexityThis = "Easy";
      } else if (widget.complexity == 1) {
        complexityThis = "Medium";
      } else if (widget.complexity == 2) {
        complexityThis = "Hard";
      } else if (widget.complexity == 3) {
        complexityThis = "Impossible";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your password could be $password",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 7.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.blue,
            child: const Text(
              "Close",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
