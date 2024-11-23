import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:slt_field_app/providers/service_provider.dart';

import '../utils/asset_constant.dart';


class ServiceTabBody extends StatefulWidget {
  const ServiceTabBody({super.key, required this.tabText});

  final String? tabText;

  @override
  State<ServiceTabBody> createState() => _ServiceTabBodyState();
}

class _ServiceTabBodyState extends State<ServiceTabBody> {

  @override
  initState() {
    super.initState();
    Logger().d('initiate');

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<ServiceProvider>(context, listen: false).getTabTest(widget.tabText)
    //       .then((value) => setState(() {}));
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        Provider.of<ServiceProvider>(context, listen: false).getTabTest(widget.tabText);
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('${widget.tabText}'),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<ServiceProvider>(context).listDisplay.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: context.width() * 0.9,
                            margin: const EdgeInsets.all(8),
                            decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //commonCacheImageWidget(Provider.of<ServiceProvider>(context).displayimage, context.height() * 0.15, width: context.width() * 0.2, fit: BoxFit.contain).center().cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                                // 2.height,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text( Provider.of<ServiceProvider>(context).listDisplay[index][1],
                                              style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                        ).expand(),
                                        // Row(
                                        //   children: [
                                        //     Icon(Icons.star, color: Colors.yellowAccent),
                                        //     Text('hh', style: secondaryTextStyle()),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text( Provider.of<ServiceProvider>(context).listDisplay[index][8] ?? '',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              )
                                          ),
                                        ).expand()
                                      ],
                                    ),
                                    if (widget.tabText == AssetConstants.peotvText)
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 5
                                                    ),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.zero)
                                                    )
                                                ),
                                                onPressed: () {

                                                },
                                                child: const Text(
                                                  'MAC Unbind',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color:  Colors.lightBlue,
                                                  ),
                                                )
                                            ),
                                          ).expand()
                                        ],
                                      ),
                                  ],
                                ).paddingOnly(left: 8, right: 8),
                                4.height,
                                // Text('d', style: secondaryTextStyle()).paddingOnly(left: 8, right: 8),
                                // 8.height,
                              ],
                            ),
                          ),
                          if (widget.tabText == AssetConstants.voiceText)
                            Container(
                              width: context.width() * 0.9,
                              margin: const EdgeInsets.all(8),
                              decoration: boxDecorationRoundedWithShadow(8, backgroundColor: context.cardColor),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  4.height,
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text( 'Customer Reference',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    )
                                                ),
                                                Text( Provider.of<ServiceProvider>(context).listDisplay[index][5],
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                                8.height,
                                                const Text( 'LEA',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    )
                                                ),
                                                Text( Provider.of<ServiceProvider>(context).listDisplay[index][7],
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    )
                                                ),
                                              ]
                                          ).expand(),
                                        ],
                                      )
                                    ],
                                  ).paddingOnly(left: 8, right: 8),
                                  4.height,
                                ],
                              ),
                            ).onTap(() {
                              // LSServiceDetailScreen().launch(context);
                            }),
                          if (widget.tabText == AssetConstants.bbText)
                            100.height,
                          if (widget.tabText == AssetConstants.bbText)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10
                                    ),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.zero)
                                    )
                                ),
                                onPressed: () {

                                },
                                child: const Text(
                                  'BB Usage',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color:  Colors.lightBlue,
                                  ),
                                )
                            ),
                          if (widget.tabText == AssetConstants.bbText)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10
                                    ),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.zero)
                                    )
                                ),
                                onPressed: () {

                                },
                                child: const Text(
                                  'Password Reset',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color:  Colors.lightBlue,
                                  ),
                                )
                            )
                        ]
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}