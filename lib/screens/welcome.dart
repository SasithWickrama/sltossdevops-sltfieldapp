import 'package:flutter/material.dart';
import  'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../controllers/login_controller.dart';
import '../models/shared_pref.dart';
import '../widgets/layer_one.dart';
import '../widgets/layer_three.dart';
import '../widgets/layer_two.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with TickerProviderStateMixin{

  late AnimationController controller;
  final SharedPref prefs =  SharedPref();

  @override
  void initState() {
    // controller = AnimationController(
    //   /// [AnimationController]s can be created with `vsync: this` because of
    //   /// [TickerProviderStateMixin].
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..addListener(() {
    //   setState(() {});
    // });
    // controller.repeat(reverse: true);
    //loadPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String tdata = DateFormat("HH").format(DateTime.now());
    String aa;


    if(int.parse(tdata) < 12 && int.parse(tdata) > 5){
      aa = "Good Morning!";
    }else if(int.parse(tdata) < 17){
      aa = "Good Afternoon!";
    }else{
      aa = "Good Evening!";
    }

    //Navigator.pushNamed(context, '/login');


    Future.delayed(const Duration(seconds: 3), () async{
      //  You action here
      print(await prefs.readvalue("isLogged"));
      print(await prefs.readvalue("sid"));

      if(await prefs.readvalue("isLogged") == "true"){

        /*final LoginController _authController = LoginController();
        await _authController.getAttendance(await prefs.readvalue("sid")).then(
                (value) async {
                  print("12");
                  print(value.data);
              if(!value.error) {
                var aa = value.data.split("-");
                aa[0] == null ? prefs.savevalue("win", "-") : prefs.savevalue("win", aa[0]);
                aa[1] == null ? prefs.savevalue("wout", "-") : prefs.savevalue("wout", aa[1]);

              }else{

              }
            });

        Navigator.pushNamed(context, '/main_home');*/
      }else{
        Navigator.pushNamed(context, '/login');
      }

    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/primaryBg.png'),
                fit: BoxFit.cover,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                      height: 80,
                      child: Image(image: AssetImage('assets/icon/hrms.png'),),
                  ),
                  SizedBox(height: 20,),
                  Text(aa),
                  SizedBox(height: 20,),
                  Container(
                    width: 100,
                    child: LinearProgressIndicator(
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );


  }

  Future<void> loadPrefs() async {
    if(await prefs.readvalue("isLogged") == "true"){
      Navigator.pushNamed(context, '/main_home');
    }else{
      Navigator.pushNamed(context, '/login');
    }

  }



}
