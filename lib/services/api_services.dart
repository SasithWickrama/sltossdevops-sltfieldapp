import 'dart:convert';
import 'package:slt_field_app/models/login_response.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../models/general_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/shared_pref.dart';
import '../utils/asset_constant.dart';

class ApiServices{

  SharedPref prefs =  SharedPref();

  Future<LoginResponse>loginRequests(String catagory, String function,var requestbody) async {
    LoginResponse loginResponce;

    Uri url = Uri.parse('${AssetConstants.baseUrl}${catagory}/${function}');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    if(await checkConnectivity()) {
      try {
        final response = await http.post(url, headers: header, body: requestbody);
        final data = json.decode(response.body);
        Logger().d(data);

        loginResponce = LoginResponse.fromJson(data);

      }catch(e){
        loginResponce = LoginResponse(
            result: 1,
            message: 'Connection Error:${e.toString()} ');
      }
    }else{
      loginResponce = LoginResponse(
          result: 1,
          message: 'No Internet Connection');
    }
    return loginResponce;
  }

  Future<GeneralResponse>generalRequests(String catagory, String function,var requestbody) async {

    GeneralResponse generalResponce;

    var token = await prefs.readvalue("token");

    Uri url = Uri.parse('${AssetConstants.baseUrl}${catagory}/${function}');
    var header = <String, String>{'Content-Type': 'application/json; charset=UTF-8','Authorization': 'Bearer $token',};
    if(await checkConnectivity()) {
      try {
        final response = await http.post(url, headers: header, body: requestbody);
        final data = json.decode(response.body);
        Logger().d(data);

        generalResponce = GeneralResponse.fromJson(data);

      }catch(e){
        generalResponce = GeneralResponse(
            result: 1,
            message: 'Connection Error:${e.toString()} ');
      }
    }else{
      generalResponce = GeneralResponse(
          result: 1,
          message: 'No Internet Connection');
    }
    return generalResponce;
  }

  Future<bool> checkConnectivity() async {
    final bool _intResult =  await InternetConnectionChecker().hasConnection ;
    return _intResult;
  }
}