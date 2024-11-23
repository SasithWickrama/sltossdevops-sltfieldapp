
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MiniIconButton extends StatelessWidget {
  MiniIconButton({
    Key? key,
    this.displayText = '',
    required this.displayIcon,
    required this.pressedFun,
    this.visibilitycheck = 'true',
  }) : super(key: key);

  String displayText;
  Icon displayIcon;
  var pressedFun;
  String visibilitycheck;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibilitycheck != '',
      child: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlue
          ),
          onPressed: pressedFun,
          icon: displayIcon,
          label: Text(
            displayText,style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
