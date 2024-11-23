// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:logger/logger.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:slt_field_app/controllers/home_controller.dart';
import 'package:slt_field_app/providers/home_provider.dart';
import 'package:slt_field_app/utils/app_colors.dart';
import 'package:slt_field_app/utils/asset_constant.dart';
import 'package:slt_field_app/utils/util_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:fl_chart/fl_chart.dart';


import '../widgets/mini_icon_button.dart';

class ServiceProvider extends ChangeNotifier{

  int voiceCount = 0;
  int bbCount = 0;
  int peotvCount = 0;

  var _showhide = false;

  List<dynamic> listAll = [];
  List<dynamic> listDisplay = [];
  set setLlistDisplay(List<dynamic> value) => listDisplay = value;
  List<dynamic> get getListDisplay => listDisplay;

  List<dynamic> listCat = [[],[],[]];
  set setlListCat(List<dynamic> value) => listCat = value;
  List<dynamic> get getListCat => listCat;

  final HomeController _homeController = HomeController();
  String displayimage = '';

  List<Tab> tabs = <Tab>[];
  set setTab(List<Tab> value) => tabs = value;

  List<Widget> aa  = [];
  List<Widget> peo = [];
  List<Widget> bb = [];

  Future<void> getTabTest(String? tabindex)  async {
    Logger().d(tabindex);
    switch (tabindex) {
      case AssetConstants.voiceText:
        listDisplay = listCat[0];
        displayimage = AssetConstants.voice;
        break;
      case AssetConstants.bbText:
        listDisplay = listCat[1];
        displayimage = AssetConstants.broadband;
        break;
      case AssetConstants.peotvText:
        listDisplay = listCat[2];
        displayimage = AssetConstants.peotv;
        break;
    }
    notifyListeners();
  }


  Future<void> displayServices(BuildContext context) async {

    int touchedIndex = -1;

    List<PieChartSectionData> showingStandard() {
      return List.generate(2, (i) {
        final isTouched = i == touchedIndex;
        final radius = isTouched ? 60.0 : 50.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              showTitle: false,
              color: Colors.greenAccent.shade400,
              value: 94,
              radius: radius,
              titleStyle: boldTextStyle(color: white),
            );
          case 1:
            return PieChartSectionData(
              showTitle: false,
              color: Colors.blueGrey,
              value: 6,
              radius: radius,
              titleStyle: boldTextStyle(color: white),
            );
          default:
            throw Error();
        }
      });
    }

    List<PieChartSectionData> showingTotal() {
      return List.generate(2, (i) {
        final isTouched = i == touchedIndex;
        final radius = isTouched ? 60.0 : 50.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              showTitle: false,
              color: Colors.greenAccent.shade400,
              value: 94,
              radius: radius,
              titleStyle: boldTextStyle(color: white),
            );
          case 1:
            return PieChartSectionData(
              showTitle: false,
              color: Colors.blueGrey,
              value: 6,
              radius: radius,
              titleStyle: boldTextStyle(color: white),
            );
          default:
            throw Error();
        }
      });
    }

    Widget dataPieChart({required Color color, required String name}) {
      return Row(
        children: [
          Container(height: 25, width: 25, color: color),
          16.width,
          Text(name, style: boldTextStyle(color: white)),
        ],
      );
    }

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;

    final _formKey = GlobalKey<FormState>();

    HomeProvider homepro = Provider.of<HomeProvider>(context, listen: false) ;
    //Navigator.pushNamed(context, '/services');
          // Logger().d(value.data);
          tabs.clear();
          aa = [];
          peo = [];
          bb = [];
          tabs = [];

          if(Provider.of<HomeProvider>(context, listen: false).voiceCount != 0){
            tabs.add(
                const Tab(
                  icon: Icon(Icons.phone),
                  text: AssetConstants.voiceText,
                )
            );
            
            aa.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bgimage.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.2,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),

                      ]
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Column(
                      children: [

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration:  const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/icon/telephone.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(homepro.voiceList[0][1], style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800, color: Colors.lightBlue),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.green,
                          thickness: 1,
                          indent : 5,
                          endIndent : 10,
                        ),
                        SizedBox(height: 20,),
                        Text(homepro.voiceList[0][2], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.purpleAccent),),
                        Text(homepro.voiceList[0][3], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.greenAccent),),
                        Text(homepro.voiceList[0][5], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.lightBlue),),
                        Text(homepro.voiceList[0][6], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.lightBlue),),
                        Text(homepro.voiceList[0][7], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.lightBlue),),
                        SizedBox(height: 20,),
                        if (!homepro.vfaultno.isEmptyOrNull ||  !homepro.bfaultno.isEmptyOrNull || !homepro.pfaultno.isEmptyOrNull) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MiniIconButton(
                                  displayIcon: const Icon(Icons.router_rounded),
                                  displayText: 'Update ONT      ',
                                  visibilitycheck: "yes",
                                  pressedFun: () {
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
                                                    const Text("Delete ONT S/N", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                                                    Row(
                                                    children: [
                                                      Container(
                                                        width : width * 0.6,
                                                        margin: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: context.scaffoldBackgroundColor),
                                                        alignment: Alignment.center,
                                                        child: AppTextField(
                                                            controller: Provider.of<HomeProvider>(context).oldOntSnController,
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
                                                          UtilFunction.scan(Provider.of<HomeProvider>(context, listen: false).oldOntSnController, "ONT");
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
                                                          Provider.of<HomeProvider>(context, listen: false).clearOntData(context);
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w800))
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          foregroundColor: Colors.white,
                                                          backgroundColor: Colors.purpleAccent
                                                        ),
                                                        onPressed: () {
                                                          if (_formKey.currentState!.validate()) {
                                                            context.loaderOverlay.show();
                                                            Provider.of<HomeProvider>(context, listen: false).deleteOntUser(context);
                                                            Navigator.of(context).pop();
                                                          }
                                                        },
                                                        child: Text('Delete User', style: TextStyle(fontWeight: FontWeight.w800))
                                                      ),
                                                    ],
                                                  ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                            ],
                          ),
                        ],
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if(Provider.of<HomeProvider>(context, listen: false).bbCount != 0){
            tabs.add(
                 const Tab(
                  icon: Icon(Icons.wifi),
                  text: AssetConstants.bbText,
                )
            );

            for(var i=0; i< Provider.of<HomeProvider>(context, listen: false).bbCount; i++) {
              bb.add(
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bgimage.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.2,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),

                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icon/internet.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(homepro.bbList[0][1], style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.lightBlue),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.green,
                          thickness: 1,
                          indent: 5,
                          endIndent: 10,
                        ),
                        SizedBox(height: 20,),
                        Text(homepro.bbList[0][2], style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.purpleAccent),),
                        Text(homepro.bbList[0][3], style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.greenAccent),),
                        Text(homepro.bbList[0][8], style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.lightBlue),),
                        SizedBox(height: 30,),
                        if (!homepro.vfaultno.isEmptyOrNull ||  !homepro.bfaultno.isEmptyOrNull) ...[
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MiniIconButton(
                                displayIcon: Icon(Icons.logout),
                                displayText: 'Password Reset',
                                visibilitycheck: "yes",
                                pressedFun: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          content: const Text('Please Confirm the Reset Password',
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900,fontSize: 16),),
                                          actions: [
                                            // The "Yes" button
                                            TextButton(
                                              onPressed: () {
                                                context.loaderOverlay.show();
                                                bbPwReset(homepro.bbList[0][1].toString(),context);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Confirm' ,
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel',
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),)
                                          ],
                                        );
                                      });
                                }),
                          ],
                          )
                        ],
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MiniIconButton(
                                displayIcon: Icon(Icons.logout),
                                displayText: 'Usage Check      ',
                                visibilitycheck: "yes",
                                pressedFun: () {
                                  context.loaderOverlay.show();
                                  bbServices(homepro.bbList[0][1].toString(),context);
                                }),
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              );
            }
            aa.add(
                Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: bb,
                          );
                        })


                )

            );
          }
          if(Provider.of<HomeProvider>(context, listen: false).peotvCount != 0){
            tabs.add(
                const Tab(
                  icon: Icon(Icons.tv_rounded),
                  text: AssetConstants.peotvText,
                )
            );

            for(var i=0; i< Provider.of<HomeProvider>(context, listen: false).peotvCount; i++){
              peo.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bgimage.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.2,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),

                      ]
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Column(
                      children: [

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration:  const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/icon/smart-tv.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(homepro.iptvList[i][1], style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800, color: Colors.lightBlue),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        const Divider(
                          height: 5,
                          color: Colors.green,
                          thickness: 1,
                          indent : 5,
                          endIndent : 10,
                        ),
                        SizedBox(height: 20,),
                        Text(homepro.iptvList[i][2], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.purpleAccent),),
                        Text(homepro.iptvList[i][3], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.greenAccent),),
                        Text(homepro.iptvList[i][8], style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500, color: Colors.lightBlue),),
                        SizedBox(height: 30,),
                      if (!homepro.pfaultno.isEmptyOrNull ) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MiniIconButton(
                                displayIcon: Icon(Icons.logout),
                                displayText: 'MAC Unbind',
                                visibilitycheck: "Yes",
                                pressedFun: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          content: const Text('Please Confirm the MAC Unbind',
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900,fontSize: 16),),
                                          actions: [
                                            // The "Yes" button
                                            TextButton(
                                              onPressed: () {
                                                context.loaderOverlay.show();
                                                macUnbind(homepro.iptvList[i][1], homepro.iptvList[i][2], homepro.iptvList[i][10] ?? "", context);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Confirm' ,
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel',
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),)
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MiniIconButton(
                                displayIcon: Icon(Icons.logout),
                                displayText: 'PIN Reset   ',
                                visibilitycheck: "Yes",
                                pressedFun: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          content: const Text('Please Confirm the PIN Reset',
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900,fontSize: 16),),
                                          actions: [
                                            // The "Yes" button
                                            TextButton(
                                              onPressed: () {
                                                context.loaderOverlay.show();
                                                macPinReset(homepro.iptvList[i][1], homepro.iptvList[i][2], homepro.iptvList[i][10] ?? "", context);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Confirm' ,
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel',
                                                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),),
                                              style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: Colors.lightBlue),)
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                        ],
                        SizedBox(height: 20,),


                      ],
                    ),
                  ),
                ),
              ),
              );
            }
            aa.add(
              Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: peo,
                      );
                    })


                )

            );
          }

          listCat = [[],[],[]];

          for (var item in Provider.of<HomeProvider>(context, listen: false).dataList) {
            // Logger().d(item);
            var serviceType = item[2].split(' ')[0];
            switch (serviceType) {
              case 'V-VOICE':
                listCat[0].add(item);
                break;
              case 'BB-INTERNET':
                listCat[1].add(item);
                break;
              case 'E-IPTV':
                listCat[2].add(item);
                break;
            }
          }
          Logger().d(tabs);
          // Logger().d(listCat);

  }

  Future<void> bbServices(String bbno,BuildContext context) async {
    List<dynamic> usageList=[], usageDetails=[];
    String slimit="", tlimit="" ;

    await _homeController.bbusageRequest(bbno.toString(), Provider.of<HomeProvider>(context,listen: false).userLoad.sid.toString()).then(
            (value) async {
              context.loaderOverlay.hide();
              if(value.result == 0) {
                usageList = value.data;
                usageDetails = usageList[0]['dataBundle']['my_package_info']['usageDetails'];
                // usageList = usageList[0]['dataBundle']['my_package_info']['usageDetails'];
                Logger().d(usageDetails[0]);

                slimit = usageDetails[0]['used']+usageDetails[0]['volume_unit']+" Used of "+usageDetails[0]['limit']+usageDetails[0]['volume_unit']+" (valid Till : "+usageDetails[0]['expiry_date']+")";

                List<PieChartSectionData> showingStandard( usage, limit) {

                  double perval = double.parse(usage) / double.parse(limit) * 100 ;
                  double remval = 100 - perval;

                  return List.generate(2, (i) {
                    const radius = 50.0;
                    switch (i) {
                      case 0:
                        return PieChartSectionData(
                          showTitle: false,
                          color: Colors.greenAccent.shade400,
                          value: remval,
                          radius: radius,
                          titleStyle: boldTextStyle(color: white),
                        );
                      case 1:
                        return PieChartSectionData(
                          showTitle: false,
                          color: Colors.blueGrey,
                          value: perval,
                          radius: radius,
                          titleStyle: boldTextStyle(color: white),
                        );
                      default:
                        throw Error();
                    }
                  });
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      scrollable: true,
                      content: Column(
                        children: [
                          SizedBox(height: 15,),
                          const Text("Broadband Usege Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                          SizedBox(height: 10,),
                          RichText(
                            text:  TextSpan(
                              text: 'Current Speed is ', style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700,color: AppColors.logoLightBlue),
                              children: <TextSpan>[
                                TextSpan(
                                  text: usageList[0]['dataBundle']['status'].toString(), style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700,color: Colors.red),),
                                TextSpan(
                                    text: ' right now ', style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700,color: AppColors.logoLightBlue)),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          const Divider(
                            height: 5,
                            color: Colors.green,
                            thickness: 1,
                            indent: 5,
                            endIndent: 10,
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 600,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: usageDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return  Container(
                                    height: 320,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            top:10,
                                            child: Text(usageDetails[index]['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.purple.shade700))),
                                          PieChart(
                                            PieChartData(
                                              centerSpaceColor: Colors.white,
                                              startDegreeOffset: 270,
                                              sections: showingStandard(usageDetails[index]['used'],usageDetails[index]['limit']),
                                              borderData: FlBorderData(show: false),
                                              centerSpaceRadius: 60,
                                              sectionsSpace: 0,
                                            ),
                                          ),
                                          Center(
                                            child: RichText(
                                              text:  TextSpan(
                                                text: usageDetails[index]['percentage'].toString()+'% \n', style: TextStyle(fontSize: 24,fontWeight:FontWeight.w700,color: AppColors.logoLightBlue),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'REMAINING', style: TextStyle(fontSize: 12,fontWeight:FontWeight.w700,color: Colors.red),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top:280,
                                              child: Text(usageDetails[index]['used']+usageDetails[index]['volume_unit']+" Used of "+usageDetails[index]['limit']+usageDetails[index]['volume_unit']+" (valid Till : "+usageDetails[index]['expiry_date']+")"
                                                  , style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.lightBlue.shade700))),

                                        ]
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      actions: [
                        MiniIconButton(
                            displayIcon: Icon(Icons.close),
                            displayText: 'Cancel',
                            visibilitycheck: "1",
                            pressedFun: () {
                              Navigator.pop(context);
                            })
                        // ElevatedButton(
                        //   child: const Text("close"),
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        // ),
                      ],
                    );
                  },
                );
              }



            });




    // await _homeController.bbusageRequest(bbno).then(
    //         (value) async {
    //           Logger().d(value);
    //         }
    // );

  }

  Future<void> bbPwReset(String bbno,BuildContext context) async {
    await _homeController.bbpwresetRequest(bbno.toString(), Provider.of<HomeProvider>(context,listen: false).userLoad.sid.toString()).then(
            (value) async {
              context.loaderOverlay.hide();
              Logger().d(value);

              if (value.result == 1) {
                QuickAlert.show(
                barrierDismissible: false,
                context: context,
                type: QuickAlertType.error ,
                text: value.message,
                );
              }
              else if (value.result == 0) {
                QuickAlert.show(
                  barrierDismissible: false,
                  context: context,
                  type:  QuickAlertType.success,
                  title: '',
                  widget:
                    Center(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.report_problem,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 10,),
                              Text("Password will display only once. \n Please use it promptly. ",
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 18),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(value.data,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22,),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text("Password responsibility will be with relevant OPMC",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )
                );
              }
            });
  }

  Future<void> macUnbind(String peono, String serviceType, String platform, BuildContext context) async {
    await _homeController.macUnbindRequest(Provider.of<HomeProvider>(context,listen: false).vnoController.text, serviceType.toString(), platform.toString(), Provider.of<HomeProvider>(context,listen: false).userLoad.sid.toString()).then(
            (value) async {
          context.loaderOverlay.hide();
          Logger().d(value);

          if (value.result == 1) {
            QuickAlert.show(
            barrierDismissible: false,
            context: context,
            type: QuickAlertType.error ,
            text: value.message,
            );
          }
          else if (value.result == 0) {
            QuickAlert.show(
              barrierDismissible: false,
              context: context,
              type:  QuickAlertType.success,
              text: "MAC unbind is successful.",
            );
          }
        });
  }

  Future<void> macPinReset(String peono, String serviceType, String platform, BuildContext context) async {
    await _homeController.macPinResetRequest(Provider.of<HomeProvider>(context,listen: false).vnoController.text, serviceType.toString(), platform.toString(), Provider.of<HomeProvider>(context,listen: false).userLoad.sid.toString()).then(
            (value) async {
          context.loaderOverlay.hide();
          Logger().d(value);
          
          if (value.result == 1) {
            QuickAlert.show(
            barrierDismissible: false,
            context: context,
            type: QuickAlertType.error ,
            text: value.message,
            );
          }
          else if (value.result == 0) {
            QuickAlert.show(
              barrierDismissible: false,
              context: context,
              type:  QuickAlertType.success,
              text: "MAC PIN reset is successful.",
            );
          }
        });
  }
}
