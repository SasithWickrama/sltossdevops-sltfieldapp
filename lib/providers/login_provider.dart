import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:crypto/crypto.dart';
import '../controllers/login_controller.dart';
import '../models/shared_pref.dart';
import '../models/user.dart';
import '../utils/asset_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginProvider extends ChangeNotifier{
  final LoginController _authController = LoginController();
  final Future<SharedPreferences> _shareprefs = SharedPreferences.getInstance();



  final _sidController = TextEditingController();
  TextEditingController get sidController => _sidController;

  final _passwdController = TextEditingController();
  TextEditingController get passwdController => _passwdController;

  Future<void> submitData(BuildContext context) async {
    final SharedPreferences shareprefs = await _shareprefs;
    SharedPref prefs = await SharedPref();
    //Navigator.pushNamed(context, '/home');
    if (!shareprefs.containsKey('deviceid')) {
      var bytes = utf8.encode(
          "${DateTime.now().millisecondsSinceEpoch}${AssetConstants.secret}");
      var digest = sha1.convert(bytes);
      // Logger().i(digest.toString());
      shareprefs.setString('deviceid', digest.toString());
    }

    print("clicked");
    await _authController.loginRequest(_sidController.text,_passwdController.text,shareprefs.getString('deviceid').toString()).then(
            (value) async {
          print(value.data);
          //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
          if(value.result == 0){

            List<Users> temp = (value.data as List)
                .map((itemWord) => Users.fromJson(itemWord))
                .toList();

             prefs.save("users", temp[0]);
             prefs.savevalue("token", value.token.toString());
             prefs.savevalue("isLogged", "true");

            context.loaderOverlay.hide();
            Navigator.pushNamed(context, '/home');
          }else{
            context.loaderOverlay.hide();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: 'Login Failed!',
            );
            //Navigator.pushNamed(context, '/home');
          }
        }
    );
  }
}