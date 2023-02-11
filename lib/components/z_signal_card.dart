import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:insigh/components/share_trade_button.dart';
import 'package:insigh/components/signal_card_sharing.dart';
import 'package:insigh/components/z_card.dart';
import 'package:insigh/utils/common_methods.dart';

import '../models/signal.dart';
import '../pages/user/signal_analysis_page.dart';
import '../pages/user/tradingview_page.dart';
import '../utils/color_constants.dart';
import '../utils/z_format.dart';
import '../constants/app_colors.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';

class ZSignalCard extends StatefulWidget {
  ZSignalCard(this.showShareButton, {Key? key, required this.signal}) : super(key: key);
  final Signal signal;
  final bool showShareButton;

  @override
  State<ZSignalCard> createState() => _ZSignalCardState();
}

class _ZSignalCardState extends State<ZSignalCard> {

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    var totalGain = calculateTotalGain(widget.signal.ltpPrice, widget.signal.entry);
    return Column(
      children: [
        ZCard(
          padding: EdgeInsets.all(12),
          color: Colors.transparent,
          borderRadiusColor: isLightTheme ? Colors.grey.shade300 : Colors.white12,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: widget.signal.entryType == 'Sell' ? appColorRed : AppColors.tradeSuggestionCardColor, borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      margin: EdgeInsets.only(bottom: 3),
                      child: Text('${widget.signal.entryType.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11.5)),
                    ),
                    SizedBox(width: 6),
                    Text(widget.signal.symbol, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, height: 0)),
                    SizedBox(width: 6),
                    Text(
                      '${ZFormat.dateFormatStr(widget.signal.entryDatetime)}',
                      style: TextStyle(fontSize: 12),
                    ),
                    Spacer(),
                    getStatus(widget.signal),
                    SizedBox(width: 8,),
                    widget.showShareButton ? ShareTradeButton(widget.signal) : SizedBox(),
                  ],
                ),

                SizedBox(height: 12),
                Row(children: [
                  Text(
                    'BO Level',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  ),
                  Spacer(),
                  Text(widget.signal.entry.toString()),
                ]),
                SizedBox(height: 8),
                //
                Row(children: [
                  Text('Stop Loss', style: TextStyle(color: Theme.of(context).textTheme.caption!.color)),
                  SizedBox(width: 4),
                  Text('(${widget.signal.getStopLossPipsOrPercentage})'),
                  Spacer(),
                  Text('${ZFormat.toPrecision(widget.signal.stopLoss, 8)}'),
                ]),

                SizedBox(height: 8),
                //
                widget.signal.ltpPrice > widget.signal.entry ? Row(children: [
                  Text('Total Gain', style: TextStyle(color: Theme.of(context).textTheme.caption!.color)),
                  Spacer(),
                  Text('(${ZFormat.toPrecision(totalGain, 2)} %)'),
                ]) : SizedBox(),
                //
                SizedBox(height: 8),
                ConfigurableExpansionTile(
                  headerExpanded: Flexible(
                    child: ZCard(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Text("Ltp Price", style: TextStyle()),
                          SizedBox(width: 12,),
                          Text(widget.signal.ltpPrice.toStringAsFixed(2), style: TextStyle()),
                          SizedBox(width: 12,),
                          Text(widget.signal.changePercent.toStringAsFixed(2) + "%", style: TextStyle(color: getPercentChangeColor(widget.signal.changePercent!))),
                          SizedBox(width: 12,),
                          Spacer(),
                          Text("View Target", style: TextStyle()),
                          SizedBox(width: 12,),
                          Icon(Icons.keyboard_arrow_up, size: 16),
                        ],
                      ),
                    ),
                  ),
                  header: Flexible(
                    child: ZCard(
                      // borderRadiusColor: Colors.white12,
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      margin: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ltp Price", style: TextStyle()),
                          SizedBox(width: 12,),
                          Text(widget.signal.ltpPrice.toStringAsFixed(2), style: TextStyle()),
                          SizedBox(width: 12,),
                          Text(widget.signal.changePercent.toStringAsFixed(2) + "%", style: TextStyle(color: getPercentChangeColor(widget.signal.changePercent!))),
                          SizedBox(width: 12,),
                          Spacer(),
                          Text("View Target", style: TextStyle()),
                          SizedBox(width: 12,),
                          Icon(Icons.keyboard_arrow_down, size: 16),
                        ],
                      ),
                    ),
                  ),
                  childrenBody: Column(
                    children: [
                      SizedBox(height: 8),
                      _buildTargetCard(
                          name: 'Target 1',
                          pipsPercentageTarget: widget.signal.getTakeProfit1PipsOrPercentage,
                          target: widget.signal.takeProfit1,
                          isTargetHit: widget.signal.isTakeProfit1Hit,
                          signal: widget.signal),
                      _buildTargetCard(
                          name: 'Target 2',
                          pipsPercentageTarget: widget.signal.getTakeProfit2PipsOrPercentage,
                          target: widget.signal.takeProfit2,
                          isTargetHit: widget.signal.isTakeProfit2Hit,
                          signal: widget.signal),
                      _buildTargetCard(
                          name: 'Target 3',
                          pipsPercentageTarget: widget.signal.getTakeProfit3PipsOrPercentage,
                          target: widget.signal.takeProfit3,
                          isTargetHit: widget.signal.isTakeProfit3Hit,
                          signal: widget.signal),
                      SizedBox(height: 12),
                      Row(children: [Text(getStatusText(widget.signal))]),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ZCard(
                        onTap: () => Get.to(() => TradingViewPage(symbol: widget.signal.symbol), fullscreenDialog: true),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('View Chart', style: TextStyle(color: AppColors.whiteColor)),
                            SizedBox(width: 4),
                            Icon(AntDesign.piechart, size: 14, color: AppColors.whiteColor),
                          ],
                        ),
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    if (widget.signal.hasAnalysis) SizedBox(width: 8),
                    if (widget.signal.hasAnalysis)
                      Expanded(
                        child: ZCard(
                          onTap: () => Get.to(() => SignalAnalysisPage(signal: widget.signal), fullscreenDialog: true),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('View Analysis'),
                              SizedBox(width: 4),
                              Icon(AntDesign.antdesign, size: 14),
                            ],
                          ),
                          margin: EdgeInsets.zero,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Divider(color: Colors.white12, height: 10, thickness: 1)
      ],
    );
  }

  _buildTargetCard(
      {required String name, required String pipsPercentageTarget, required num target, required bool isTargetHit, required Signal signal}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isTargetHit ? appColorGreen.withOpacity(.6).withOpacity(.6) : Color(0X203E436D),
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width * .4,
          child: Text('${name}', style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontWeight: FontWeight.bold)),
        ),
        Text('${pipsPercentageTarget}'),
        Spacer(),
        if (target != 0) Text('${ZFormat.toPrecision(target, 8)}'),
        if (target == 0) Text('N/A'),
        SizedBox(width: 4),
        if (isTargetHit) Icon(Icons.check, color: Colors.white, size: 16),
      ]),
    );
  }

  getStatus(Signal signal) {
    if (signal.isTakeProfit3Hit) return buildTradeStatusContainer(text: 'Target 3', isProfit: true);
    if (signal.isTakeProfit2Hit) return buildTradeStatusContainer(text: 'Target 2', isProfit: true);
    if (signal.isTakeProfit1Hit) return buildTradeStatusContainer(text: 'Target 1', isProfit: true);
    if (signal.isStopLossHit) return buildTradeStatusContainer(text: 'Stop Loss', isProfit: false);
    return buildTradeStatusContainer(text: 'In progress', isProfit: true, isInProgress: true);
  }

}


