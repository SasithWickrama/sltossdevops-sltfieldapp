import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:slt_field_app/providers/home_provider.dart';
import 'package:slt_field_app/providers/service_provider.dart';

import '../widgets/tab_body.dart';


class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceState();
}

class _ServiceState extends State<ServiceDetails> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          Provider.of<ServiceProvider>(context, listen: false).displayServices(context);
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return DefaultTabController(
      length: Provider.of<ServiceProvider>(context).aa.length,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Services" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),),
            centerTitle: true,
            backgroundColor: Colors.lightBlueAccent,
            foregroundColor: Colors.white,
            bottom:  TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              isScrollable: false,
              tabs: Provider.of<ServiceProvider>(context).tabs,
            ),
          ),
          body:  TabBarView(
            children: Provider.of<ServiceProvider>(context).aa,
          ),
        ),
      ),
    );


  }
}