import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:slt_field_app/models/general_response.dart';

import '../services/api_services.dart';

class HomeController {
  Future<GeneralResponse> serviceRequest(String vno,String sid,List<dynamic> rtarea) async {
    var requestbody = jsonEncode(<String, dynamic>{
      'vno': vno,
      'sid': sid,
      'rtarea': rtarea,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","getservices", requestbody);

  }

  Future<GeneralResponse> detailRequest(String vno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'vno': vno,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","getdetails", requestbody);

  }

  Future<GeneralResponse> billRequest(String accno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'ano': accno,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","getbill", requestbody);

  }

  Future<GeneralResponse> pendingFaultsRequest(String fno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'fno': fno,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("faults", "getfaultdetails", requestbody);
  }

  Future<GeneralResponse> bbusageRequest(String bbno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'bbUsername': bbno,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers", "getbroadbandusage", requestbody);
  }

  Future<GeneralResponse> bbpwresetRequest(String bbno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'circuit': bbno,
      'action':'modifypw',
      'BBpassword':'SLT#9542',
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers", "getbroadbandpwreset", requestbody);
  }

  Future<GeneralResponse> macUnbindRequest(String peono, String serviceType, String platform, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'peotvUsername': peono,
      'serviceType': serviceType,
      'platform': platform,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers", "getpeotvbind", requestbody);
  }

  Future<GeneralResponse> macPinResetRequest(String peono, String serviceType, String platform, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'peotvUsername': peono,
      'serviceType': serviceType,
      'platform': platform,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers", "getpeopinreset", requestbody);
  }
  
  Future<GeneralResponse> eqMSANRequest(String vno, String sid) async {
    var requestbody = jsonEncode(<String, String>{
      'vno': vno,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","geteqmsandetails", requestbody);

  }

  Future<GeneralResponse> acsDeleteUser(var acsDeleteInput, String sid) async {
    var requestbody = jsonEncode(<String, dynamic>{
      'acs_delete_input': acsDeleteInput,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","acsdeleteuser", requestbody);

  }

  Future<GeneralResponse> acsCreateUser(var acsCreateInput, String sid) async {
    var requestbody = jsonEncode(<String, dynamic>{
      'acs_create_input': acsCreateInput,
      'sid': sid,
    });

    Logger().i(requestbody);
    return await ApiServices().generalRequests("customers","acscreateuser", requestbody);

  }
}