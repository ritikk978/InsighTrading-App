import 'package:flutter/material.dart';
import 'package:insigh/components/screenshot_function.dart';
import 'package:insigh/models/yahoo_finance_stock_data.dart';
import 'package:insigh/utils/color_constants.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/app_colors.dart';
import '../../models_services/dynamic_links_service.dart';
import '../../utils/common_methods.dart';
class GlobalIndicesWidget extends StatelessWidget {
  List<LivePriceData> globalIndicesData;
  bool isSharing;
  GlobalIndicesWidget(this.globalIndicesData, this.isSharing, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: GridView.count(
          childAspectRatio: 1.6,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          children: List.generate(
              globalIndicesData.length + 1,
                  (index) => index == 15 ? !isSharing ? GestureDetector(
                    onTap: () {
                      ScreenshotController.captureFromWidget(GlobalIndicesWidget(globalIndicesData, true),
                          pixelRatio : 2.0,
                        targetSize: Size(
                            MediaQuery.of(context).size.width,
                            230), context: context).then((value) => {
                      DynamicLinkService().createDynamicLink().then((deepLink) {
                      Share.shareXFiles([XFile(value.path)],
                      text: "Hi, Pls find the global market insight with *InsighTrading*!  Download the app to know more insights 👇 ${deepLink.origin + deepLink.path}");

                      })
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Center(
                          child: Icon(Icons.share, size: 30,)),
                    ),
                  ) : SizedBox(): Container(
                decoration: BoxDecoration(
                    border: Border.all(color: appColorBlue,
                      width: 1.0,),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(globalIndicesData[index].compShortName!.length > 9 ? globalIndicesData[index].compShortName!.substring(0, 9) : globalIndicesData[index].compShortName!, textAlign: TextAlign.center,),
                    SizedBox(height: 4,),
                    Text(globalIndicesData[index].ltpPrice!.toStringAsFixed(1) + " (${globalIndicesData[index].regularMarketChangePercent!.toStringAsFixed(2)}%)", style: TextStyle(color: getPercentChangeColor(globalIndicesData[index].regularMarketChangePercent!), fontSize: 9),)
                  ],
                ),
              ))),
    );
  }
}
