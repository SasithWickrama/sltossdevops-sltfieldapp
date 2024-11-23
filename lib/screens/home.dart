import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:slt_field_app/providers/home_provider.dart';
import '../main.dart';
import '../utils/LSColors.dart';
import '../utils/util_functions.dart';
import '../widgets/mini_icon_button.dart';
import '../widgets/drawer_widget.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Provider.of<HomeProvider>(context, listen: false).loadUserPrefs().then((value) {
        setState(() {

        });

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;

    HomeProvider homepro = Provider.of<HomeProvider>(context, listen: false) ;

    
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  //backgroundColor: appStore.isDarkModeOn ? context.cardColor : LSColorPrimary,
                  backgroundColor: LSColorPrimary,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hello, ${homepro.userLoad.name}', style: boldTextStyle(color: white, size: 24)).paddingOnly(left: 16, right: 16),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: white, size: 20),
                            Text(homepro.ulocation.toString(),
                                softWrap: true,
                                style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500, color: Colors.white))

                          ],
                        ).paddingAll(16),
                        Row(
                          children: [
                            Container(
                              width : width * 0.75,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: context.scaffoldBackgroundColor),
                              alignment: Alignment.center,
                              child: AppTextField(
                                  controller: Provider.of<HomeProvider>(context).vnoController,
                                  textFieldType: TextFieldType.NAME,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                      fillColor: white,
                                      hintText: 'Search Circuit',
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.search, color: grey),
                                      contentPadding: EdgeInsets.only(left: 24.0, bottom: 8.0, top: 8.0, right: 24.0),
                                      ),
                                  )   ,
                            ),
                            ElevatedButton(onPressed: (){
                              context.loaderOverlay.show();
                                Provider.of<HomeProvider>(context, listen: false).submitData(context).then ((value){
                                  setState(() {
                                    if(value!="") {
                                      //Bill
                                      Provider.of<HomeProvider>(
                                          context, listen: false).getBill(
                                          context, value.toString()).then((
                                          value) {
                                        setState(() {

                                        });
                                      });
                                      //Data
                                      Provider.of<HomeProvider>(
                                          context, listen: false).getData(
                                          context).then((value) {
                                        setState(() {

                                        });
                                      });
                                      //OLT Details
                                      Provider.of<HomeProvider>(
                                          context, listen: false).getMSANdetails(
                                          context).then((value) {
                                        setState(() {

                                        });
                                      });
                                      //Fault
                                      Provider.of<HomeProvider>(
                                          context, listen: false).getOpenFault(
                                          context).then((value) {
                                        setState(() {

                                        });
                                      });
                                    }

                                  });
                                });





                            }, child: Text("GO"))
                          ],
                        ),
                      ],
                    ).paddingTop(30),
                  ),
                )
              ];
            },
            body: Container(
              color: LSColorSecondary.withOpacity(0.95),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        width: width,
                        height: 210,
                        child:   Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Services",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800),),
                                  TextButton(     // <-- TextButton
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/service');
                                    },
                                    child: const Row(
                                      children: [
                                        Text('Details',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700)),
                                        Icon(Icons.arrow_circle_right, size: 24.0,)
                                      ],
                                    ),
      
                                  )
                                ],
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.green,
                                thickness: 1,
                                indent : 5,
                                endIndent : 10,
                              ),
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
                                  SizedBox(width: 10,),

                                  Text("VOICE", style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: homepro.svcolor),),
                                  SizedBox(width: width * 0.5,),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: homepro.vcolor,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration:  const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/icon/internet.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("BROADBAND",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: homepro.sbcolor)),
                                  SizedBox(width: width * 0.37,),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: homepro.bcolor,
                                        shape: BoxShape.circle
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
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
                                  SizedBox(width: 10,),
                                  Text("PEOTV",style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: homepro.spcolor)),
                                  SizedBox(width: width * 0.49,),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: homepro.pcolor,
                                        shape: BoxShape.circle
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        width: width,
                        height: 300,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Customer Details",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800),),
      
                                ],
                              ),
                              Divider(
                                height: 5,
                                color: Colors.green,
                                thickness: 1,
                                indent : 5,
                                endIndent : 10,
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Icon(Icons.supervisor_account),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Text(homepro.cnme.toString(),
                                        softWrap: true,
                                        style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Text(homepro.caddress.toString(),
                                        softWrap: true,
                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.home_work_outlined),
                                  SizedBox(width: 10,),
                                  Text(homepro.ctype.toString(),style: TextStyle(fontSize: 14,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
      
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                // children: [
                                //   MiniIconButton(
                                //       displayIcon: Icon(Icons.directions),
                                //       displayText: 'Directions',
                                //       visibilitycheck: "7.2908622143",
                                //       pressedFun: () {
                                //         UtilFunction.openMap("7.2908622143",
                                //         "80.6230554342", "Customer Location");
                                //       }),
                                // ],
                                children: homepro.cusgps,
                              )
      
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        width: width,
                        height: 350,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Network",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800),),
                                ],
                              ),
                              Divider(
                                height: 5,
                                color: Colors.green,
                                thickness: 1,
                                indent : 5,
                                endIndent : 10,
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text("DP LOOP",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900, color: Colors.green)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.indeterminate_check_box_rounded),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Text(homepro.cdp.toString(),
                                        softWrap: true,
                                        style: TextStyle(fontSize: 16,fontWeight:FontWeight.w900, color: Colors.lightBlue)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MiniIconButton(
                                      displayIcon: Icon(Icons.directions),
                                      displayText: 'Directions',
                                      visibilitycheck: homepro.cdplat.toString(),
                                      pressedFun: () {
                                        UtilFunction.openMap(homepro.cdplat.toString(),
                                            homepro.cdplon.toString(), "FDP Location");
                                      }),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text("MSAN",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w900, color: Colors.green)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.indeterminate_check_box_rounded),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(homepro.cmsan.toString().splitBefore(' - '),style: TextStyle(fontSize: 16,fontWeight:FontWeight.w900, color: Colors.lightBlue)),
                                      Text(homepro.cmsan.toString().splitAfter(' - '),style: TextStyle(fontSize: 16,fontWeight:FontWeight.w900, color: Colors.lightBlue)),
                                    ],
                                  ),
      
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MiniIconButton(
                                      displayIcon: Icon(Icons.directions),
                                      displayText: 'Directions',
                                      visibilitycheck: homepro.cmsanlat.toString(),
                                      pressedFun: () {
                                        UtilFunction.openMap(homepro.cmsanlat.toString(),
                                            homepro.cmsanlon.toString(), "MSAN Location");
                                      }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        width: width,
                        height: 350,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Billing",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800),),
                                ],
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.green,
                                thickness: 1,
                                indent : 5,
                                endIndent : 10,
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Icon(Icons.document_scanner),
                                  SizedBox(width: 10,),
                                  Text("Invoice No - ${homepro.binvno}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: 10,),
                                  Text("Bill End Date - ${homepro.blastbill.toString().splitBefore("T")}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on_rounded),
                                  SizedBox(width: 10,),
                                  Text("Charges For The Period - Rs. ${homepro.bcharg}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on),
                                  SizedBox(width: 10,),
                                  Text("Arreas on Last Bill - Rs. ${homepro.barreas}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: 10,),
                                  Text("Last Paymont On - ${homepro.bpayon}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on),
                                  SizedBox(width: 10,),
                                  Text("Last Payment Amount - Rs. ${homepro.bpamount}",
                                      style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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
                        width: width,
                        height: 700,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Faults",style: TextStyle(fontSize: 22,fontWeight:FontWeight.w800),),
                                  TextButton(     // <-- TextButton
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/service');
                                    },
                                    child: const Row(
                                      children: [
                                        Text('Details',style: TextStyle(fontSize: 16,fontWeight:FontWeight.w700)),
                                        Icon(Icons.arrow_circle_right, size: 24.0,)
                                      ],
                                    ),

                                  )
                                ],
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.green,
                                thickness: 1,
                                indent : 5,
                                endIndent : 10,
                              ),
                              SizedBox(height: 20,),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: homepro.openFault.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Card(
                                      shadowColor: Colors.green.shade500,
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Row(
                                              children: [
                                                homepro.openFault[index][0].toString()== homepro.vfaultno.toString() ?
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration:  const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/icon/telephone.png"),
                                                    ),
                                                  ),
                                                ) :
                                                homepro.openFault[index][0].toString()== homepro.bfaultno.toString() ?
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration:  const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/icon/internet.png"),
                                                    ),
                                                  ),
                                                ) :
                                                homepro.openFault[index][0].toString()== homepro.pfaultno.toString() ?
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration:  const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/icon/smart-tv.png"),
                                                    ),
                                                  ),
                                                ): Text(""),
                                                SizedBox(width: 20,),
                                                Text(homepro.openFault[index][0].toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w700, color: Colors.redAccent)),
                                                SizedBox(width: 20,),
                                              ],
                                            ),
                                            children: <Widget>[
                                              SizedBox(height: 20,),
                                              faultDetailsRow("Status", homepro.openFault[index][1].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Reported By", homepro.openFault[index][3].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Reported On", homepro.openFault[index][4].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Reported Contact", homepro.openFault[index][5].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Priority", homepro.openFault[index][6].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Cause of Fault", homepro.openFault[index][8].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Outage", homepro.openFault[index][2].toString()),
                                              SizedBox(height: 10,),
                                              faultDetailsRow("Work Group", homepro.openFault[index][7].toString()),
                                              SizedBox(height: 10,),
                                            ]
                                          ),

                                        ],
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
      
      
      
      
                    ],
                  ),
                ),
              ),
            )
        ),
        drawer: DrawerWidget(),
      
      ),
    );

  }

  Row faultDetailsRow(String value1, String value2) {
    value1 == "1001" ? value1 = "Open" : value1 == "1002" ? value1 = "Acknowledged" : value1;

    return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value1,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w900, color: Colors.grey)),
                  Text(value2,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlue)),
                ],
              ),
            ),
          ],
        );
  }
}
