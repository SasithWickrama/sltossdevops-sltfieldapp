import 'dart:convert';

import 'package:logger/logger.dart';
import '../models/login_response.dart';
import '../services/api_services.dart';
import '../utils/asset_constant.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginController{
  Future<LoginResponse> loginRequest(String sid,String passwd, String deviceid) async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;


    Logger().d(androidDeviceInfo.id);

    var requestbody = jsonEncode(<String, dynamic>{
      'sid': sid,
      'passwd': passwd,
      'deviceid': deviceid,
      'appVer':AssetConstants.appver

    });

    Logger().i(requestbody);
    return await ApiServices().loginRequests("user","login", requestbody);

  }
}