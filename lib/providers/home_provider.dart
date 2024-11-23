import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:form_field_validator/form_field_validator.dart';


import '../controllers/home_Controller.dart';
import '../models/shared_pref.dart';
import '../models/user.dart';
import '../utils/util_functions.dart';
import '../widgets/mini_icon_button.dart';


class HomeProvider extends ChangeNotifier {
  final HomeController _homeController = HomeController();
  final SharedPref prefs =  SharedPref();

  late List<dynamic> voiceList ,bbList ,iptvList;
  List<Widget> cusgps  = [],module  = [];
  List<dynamic> dataList=[], openFault=[] ,closedFault=[], allFault=[], rt = [];


  Users userLoad = Users();
  Users get users => userLoad;


  Color vcolor = Colors.transparent;
  Color bcolor = Colors.transparent;
  Color pcolor = Colors.transparent;

  Color svcolor = Colors.lightBlue;
  Color sbcolor = Colors.lightBlue;
  Color spcolor = Colors.lightBlue;


  int voiceCount = 0, bbCount = 0, peotvCount = 0, openFaultCount = 0, closedFaultCount = 0;


  var cnme ,ctype,caddress ,cdp,cdplat, cdplon, cmsan,cmsanlat,cmsanlon, accno , binvno,blastbill,
  bcharg,barreas,bpayon,bpamount,ulocation,cgps;

  var eqlocation, eqindex, eqabbrv, eqip, eqvoiceport, eqsource, eqmsantype, eqport, eqvport, eqdname;

  String modval="", accessval="",retval="",vfaultno="", bfaultno="", pfaultno="",rtom="";

  final _vnoController = TextEditingController();
  TextEditingController get vnoController => _vnoController;

  final _oldOntSnController = TextEditingController();
  TextEditingController get oldOntSnController => _oldOntSnController;
  
  final _newOntSnController = TextEditingController();
  TextEditingController get newOntSnController => _newOntSnController;

  final _formKey = GlobalKey<FormState>();

  Future<void> loadUserPrefs() async {
    dataClear();
    Users user = Users.fromJson(await prefs.read("users"));
    userLoad = user;
    module = [];
    rt=[];

    rt=userLoad.rtarea!;

    for(var i=0;i<userLoad.module!.length;i++){
        if(userLoad.module![i].toString().splitBefore("-") == "1"){
            modval = "Customer";
        }
        if(userLoad.module![i].toString().splitBefore("-") == "2"){
          modval = "Service";
        }
        if(userLoad.module![i].toString().splitBefore("-") == "3"){
          modval = "Bill";
        }
        if(userLoad.module![i].toString().splitBefore("-") == "4"){
          modval = "Network";
        }
        if(userLoad.module![i].toString().splitBefore("-") == "5"){
          modval = "Service Orders";
        }
        if(userLoad.module![i].toString().splitBefore("-") == "6"){
          modval = "Faults";
        }

        if(userLoad.module![i].toString().splitAfter("-") == "ALL"){
          accessval = "FULL";
        }else{
          accessval = userLoad.module![i].toString().splitAfter("-");
        }

            Logger().d(userLoad.module![i].toString().splitAfter("-"));
        module.add(
         Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(modval),
                Text(accessval),
              ],
            ),
            SizedBox(height: 10,)
          ],
        )
      );
    }


    var position = await _determinePosition();

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark placeMark  = placemarks[0];
    ulocation = placeMark.thoroughfare.toString()+" , "+placeMark.subLocality.toString();
    Logger().d(placeMark.thoroughfare);
    Logger().d(placeMark.subLocality);
    Logger().d(module);
  }

  Future<String> submitData(BuildContext context) async {
    await _homeController.serviceRequest(_vnoController.text,userLoad.sid.toString(),rt).then(
            (value) async {
          //print(value.data);
          //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
          if(value.result == 0){
            dataList = value.data['records'];
            voiceCount = value.data['voice'];
            bbCount = value.data['bb'];
            peotvCount = value.data['peo'];

            vcolor = Colors.transparent;
            bcolor = Colors.transparent;
            pcolor = Colors.transparent;

            dataClear();
            // voiceList=[];
            // bbList=[];
            // iptvList=[];
            // allFault=[];
            for(var i=0; i< dataList.length;i++){

              if(dataList[i][2].contains('VOICE')){

                accno = dataList[i][6].toString();
                vfaultno = dataList[i][9].toString();
                if (vfaultno.isEmptyOrNull){
                  svcolor = Colors.lightBlue;
                }else{
                  svcolor = Colors.red;
                  allFault.add(vfaultno);
                }
                voiceList.add(dataList[i]);

                if(dataList[i][3] == 'INSERVICE'){
                  vcolor = Colors.green;
                }
                if(dataList[i][3] == 'SUSPENDED'){
                  vcolor = Colors.amber;
                }
              }
              if(dataList[i][2].contains('INTERNET')){

                bfaultno = dataList[i][9].toString();
                if (bfaultno.isEmptyOrNull){
                  sbcolor = Colors.lightBlue;

                }else{
                  sbcolor = Colors.red;
                  allFault.add(bfaultno);
                }
                bbList.add(dataList[i]);

                if(dataList[i][3] == 'INSERVICE'){
                  bcolor = Colors.green;
                }
                if(dataList[i][3] == 'SUSPENDED'){
                  bcolor = Colors.amber;
                }
              }
              if(dataList[i][2].contains('IPTV')){

                pfaultno = dataList[i][9].toString();
                if (pfaultno.isEmptyOrNull){
                  spcolor = Colors.lightBlue;

                }else{
                  spcolor = Colors.red;
                  allFault.add(pfaultno);
                }
                iptvList.add(dataList[i]);

                if(dataList[i][3] == 'INSERVICE'){
                  pcolor = Colors.green;
                }
                if(dataList[i][3] == 'SUSPENDED'){
                  pcolor = Colors.amber;
                }
              }
            }

            //getData();
            //getBill(context,accno);
            context.loaderOverlay.hide();
            //notifyListeners();

            Logger().d(voiceList);
            Logger().d(bbList);
            Logger().d(iptvList);

            retval = accno;

          }else{
            retval = "";
            dataClear();
            context.loaderOverlay.hide();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: value.message,
            );

             vcolor = Colors.transparent;
             bcolor = Colors.transparent;
             pcolor = Colors.transparent;
          }

        }
    );
    return retval;
  }

  Future<void> getData(BuildContext context) async {
    await _homeController.detailRequest(_vnoController.text,userLoad.sid.toString()).then(
            (value) async {
              Logger().d(value.data);
              cusgps = [];
              cnme = value.data['name'];
              caddress = value.data['address'];
              ctype = value.data['type'];
              cdp = value.data['dp'];
              cdplat = value.data['dplat'];
              cdplon = value.data['dplon'];
              cmsan = value.data['msan'];
              cmsanlat = value.data['msanlat'];
              cmsanlon = value.data['msanlon'];
              cgps = "";

              if(cgps == ""){
                cusgps.add(
                    MiniIconButton(
                        displayIcon: Icon(Icons.add_location),
                        displayText: 'Add Location',
                        visibilitycheck: "Yes",
                        pressedFun: () {

                        })
                );

              }else{
                cusgps.add(
                MiniIconButton(
                    displayIcon: Icon(Icons.directions),
                    displayText: 'Directions',
                    visibilitycheck: "Yes",
                    pressedFun: () {
                      UtilFunction.openMap("7.2908622143",
                          "80.6230554342", "Customer Location");
                    })
                );
              }

            } );
  }

  Future<void> getBill( BuildContext context, String acno) async {
    await _homeController.billRequest(acno,userLoad.sid.toString()).then(
            (value) async {
          Logger().d(value.data);
          binvno = value.data['invno'];
          blastbill =value.data['lastbill'];
          bcharg =double.parse((value.data['charges']).toStringAsFixed(2));
          barreas =double.parse((value.data['arreas']).toStringAsFixed(2));
          bpayon = value.data['payon'];
          bpamount = value.data['payamount'];


        } );
  }

  Future<void> getMSANdetails( BuildContext context ) async {
    await _homeController.eqMSANRequest(_vnoController.text, userLoad.sid.toString()).then(
      (value) async {
        Logger().d(value.data);
        eqlocation = value.data['eqlocation'];
        eqindex = value.data['eqindex'];
        eqabbrv = value.data['eqabbrv'];
        eqip = value.data['eqip'];
        eqvoiceport = value.data['voiceport'];
        eqsource = value.data['source'];
        eqmsantype =  value.data['msantype'];
        eqvport = value.data['vport'];
        eqdname = value.data['dname'];

        if(eqmsantype == 'ZTE') { eqport = value.data['port1']; }
        if(eqmsantype == 'HUAWEI') { eqport = value.data['port2']; }
        if(eqmsantype == 'NOKIA') { eqport = value.data['port3']; }
        
      }
    );
  }

  Future<void> getOpenFault(BuildContext context) async {
    //openFault= [];

    for(var i=0; i< allFault.length; i++){

      await _homeController.pendingFaultsRequest(allFault[i].toString(),userLoad.sid.toString()).then((value) async {
        Logger().d(value.data);
        openFault.add(value.data);
        });
    }
    Logger().d(openFault);

    // await _homeController.pendingFaultsRequest(_vnoController.text).then((value) async {
    //   Logger().d(value.data);
    //
    //   openFaultCount = 0;
    //   if(value.result == 0) {
    //     //openFaultCount = value.data['count'];
    //     //openFault = value.data['datalist'];
    //     //Logger().d(openFault[0]);
    //   }
    //
    //
    // } );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    //return await Geolocator.getCurrentPosition();
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).timeout(Duration(seconds: 3));
  }

  Future<void> clearOntData(BuildContext context) async {
    _oldOntSnController.text = "";
    _newOntSnController.text = "";
  }

  Future<void> deleteOntUser(BuildContext context) async {
     Logger().d(_oldOntSnController.text);
    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;
// _oldOntSnController.text == "" ? 
// QuickAlert.show(
//         context: context,
//         type: QuickAlertType.error,
//         text: "ONT Serial Number is Mandatory",
//       )

// : Logger().d(_oldOntSnController.text);


    if (_oldOntSnController.text == "") {
      Logger().d(_oldOntSnController.text);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: "ONT Serial Number is Mandatory",
      );
    } 
    else {

      var imsRegNo = '94${_vnoController.text.substring(1)}';
      var acsDeleteInput = <String, dynamic>{
        "msantype": eqmsantype,
        "dname": eqdname,
        "port": eqport,
        "ontSN": _oldOntSnController.text,
        "imsUserId": imsRegNo,
        "vport": eqvport.toString()
      };
      
      Logger().d(acsDeleteInput);
      await _homeController.acsDeleteUser(acsDeleteInput, userLoad.sid.toString()).then((value) async {
        if(value.result == 0) {
          context.loaderOverlay.hide();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext ctx) {
              return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollable: true,
                title: Text("Update ONT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                content: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        // const Text("Update ONT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        // SizedBox(height: 10,),
                        const Text("Create ONT S/N", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                        Row(
                        children: [
                          Container(
                            width : width * 0.6,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: context.scaffoldBackgroundColor),
                            alignment: Alignment.center,
                            child: AppTextField(
                                controller: _newOntSnController,
                                textFieldType: TextFieldType.NAME,
                                textAlignVertical: TextAlignVertical.center,
                                validator: MultiValidator([RequiredValidator(errorText: 'ONT Serial Number is Mandatory')]),
                                decoration: const InputDecoration(
                                    fillColor: white,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 24.0, bottom: 8.0, top: 8.0, right: 24.0),
                                    ),
                                )   ,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.lightBlue
                            ),
                            onPressed: () {
                              UtilFunction.scan(_newOntSnController, "ONT");
                            },
                            child: Text('Scan', style: TextStyle(fontWeight: FontWeight.w800))
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orangeAccent
                            ),
                            onPressed: () {
                              clearOntData(context);
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w800))
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purpleAccent
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.loaderOverlay.show();
                                var acsCreateInput = <String, dynamic>{
                                  "msantype": eqmsantype,
                                  "dname": eqdname,
                                  "port": eqport,
                                  "vport": eqvport.toString(),
                                  "ontSN": _newOntSnController.text,
                                  "imsUserId": imsRegNo,
                                  "regId": _vnoController.text,
                                  "iptvCount": peotvCount.toString(),
                                  "bbCount": bbCount.toString(),
                                  "source": eqsource,
                                  "voiceport": eqvoiceport.toString()
                                };
                                Logger().w(acsCreateInput);
                                await _homeController.acsCreateUser(acsCreateInput, userLoad.sid.toString()).then((value) async {
                                  if(value.result == 0) {
                                    context.loaderOverlay.hide();
                                    Navigator.of(context).pop();
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: value.data,
                                    );
                                  } else if (value.result == 1) {
                                    context.loaderOverlay.hide();
                                    clearOntData(context);
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: value.message,
                                    );
                                  }
                                });
                              }
                            },
                            child: Text('Create User', style: TextStyle(fontWeight: FontWeight.w800))
                          ),
                        ],
                      ),
                      ],
                    ),
                  ),
                ),
              );
            });
        }
        else if(value.result == 1) {
          context.loaderOverlay.hide();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: value.message,
          );
          clearOntData(context);
        }
      });
    }
  }

  dataClear(){
    voiceList=[];
    bbList=[];
    iptvList=[];
    allFault=[];

    cusgps = [];
    cnme = "";
    caddress = "";
    ctype = "";
    cdp = "";
    cdplat = "";
    cdplon = "";
    cmsan = "";
    cmsanlat = "";
    cmsanlon = "";
    cgps = "";

    binvno = "";
    blastbill ="";
    bcharg ="";
    barreas ="";
    bpayon = "";
    bpamount = "";

    openFault= [];

    eqlocation = "";
    eqindex = "";
    eqabbrv = "";
    eqip = "";
    eqvoiceport = "";
    eqsource = "";
    eqmsantype =  "";
    eqvport = "";
    eqdname = "";
    eqport = "";

    _oldOntSnController.text = "";
    _newOntSnController.text = "";

  }

}