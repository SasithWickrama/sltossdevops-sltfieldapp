import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../providers/home_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    final homepro = Provider.of<HomeProvider>(context, listen: false) ;

    String uImage = "https://serviceportal.slt.lk/ApiNeylie/img/${homepro.userLoad.sid.toString()}.png";

    return Drawer(
      child: ListView(
        children: <Widget>[
            UserAccountsDrawerHeader(
            accountName:  Text(homepro.userLoad.name.toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w900,)),
            accountEmail: Text(homepro.userLoad.contact.toString(),style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700,)),
            decoration: const BoxDecoration(color: Colors.lightBlue),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(uImage)),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlueAccent)),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlueAccent)),
              onTap: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.custom,
                   confirmBtnText: 'Close',
                  widget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Column(
                        children: homepro.module,
                      ),
                    ),
                  )
                );
              }),
          const Divider(
            height: 5,
            color: Colors.green,
            thickness: 1,
            indent : 5,
            endIndent : 10,
          ),
          ListTile(
              leading: Icon(Icons.info),
              title: Text("About",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlueAccent)),
              onTap: () {
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Logout",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w700, color: Colors.lightBlueAccent)),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              }),
        ],
      ),
    );
  }
}




