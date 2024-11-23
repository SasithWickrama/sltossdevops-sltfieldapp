import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../widgets/layer_one.dart';
import '../widgets/layer_three.dart';
import '../widgets/layer_two.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgimage.jpg'),
                fit: BoxFit.cover,
              )),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 100,
                  left: 45,
                  child: Container(
                    child: const Text(
                      'SLT - FIELD SERVICE',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  )),
              Positioned(top: 200, right: 0, bottom: 0, child: LayerOne()),
              Positioned(top: 220, right: 0,left: 20, bottom: 28, child: LayerTwo()),
              Positioned(top: 224, right: 0, left: 20,bottom: 48, child: LayerThree()),
            ],
          ),
        ),
      ),
    );
  }
}
