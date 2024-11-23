
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class UtilFunction {
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<void> openMap(String lat, String lng, String mapTitle) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(lat), double.parse(lng)),
      title: mapTitle,
    );
  }

  // static void callNumber(String number) {
  //   if (number.length == 10) {
  //     Uri tp = Uri(scheme: "tel", path: number);
  //     launchUrl(tp);
  //   }
  // }

  static Future<void> scan(TextEditingController x, String type) async {
    String tempSN = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    x.text = tempSN == '-1' ? '' : tempSN;
  }


}
