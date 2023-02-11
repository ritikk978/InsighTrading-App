import 'package:flutter/material.dart';
import 'package:insigh/components/z_card.dart';
import 'package:insigh/utils/color_constants.dart';

import '../models/signal.dart';
import '../utils/common_methods.dart';
import '../utils/z_format.dart';
import '../constants/app_colors.dart';
import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';

class ZSignalClosedCard extends StatefulWidget {
  ZSignalClosedCard({Key? key, required this.signal}) : super(key: key);
  final Signal signal;

  @override
  State<ZSignalClosedCard> createState() => _ZSignalClosedCardState();
}

class _ZSignalClosedCardState extends State<ZSignalClosedCard> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
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
                          color: widget.signal.entryType == 'Buy' ? AppColors.tradeSuggestionCardColor : appColorRed, borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      margin: EdgeInsets.only(bottom: 3),
                      child: Text('${widget.signal.entryType.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
                    ),
                    SizedBox(width: 6),
                    Text(widget.signal.symbol, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, height: 0)),
                    SizedBox(width: 6),
                    Text(
                      '${ZFormat.dateFormatSignal(widget.signal.stopLossDatetime)}',
                      style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 11),
                    ),
                    Spacer(),
                    getStatus(widget.signal),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(height: 8),
                Row(children: [
                  Text(
                    'BO level',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  ),
                  SizedBox(width: 4),
                  Spacer(),
                  SizedBox(width: 4),
                  Text(widget.signal.entry.toString()),
                ]),
                SizedBox(height: 8),
                Row(children: [
                  Text(
                    'Stop Loss',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
                  ),
                  SizedBox(width: 4),
                  Text('(${widget.signal.getStopLossPipsOrPercentage})'),
                  Spacer(),
                  SizedBox(width: 4),
                  Text('${ZFormat.toPrecision(widget.signal.stopLoss, 8)}'),
                ]),
                SizedBox(height: 8),
                Text(
                  'Posted on ${ZFormat.dateFormatStr(widget.signal.entryDatetime)}',
                  style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 12),
                ),
                SizedBox(height: 8),
                ConfigurableExpansionTile(
                  headerExpanded: Flexible(
                    child: ZCard(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .35,
                            child: Text("View Targets", style: TextStyle()),
                          ),
                          Spacer(),
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
                          Container(
                            width: MediaQuery.of(context).size.width * .35,
                            child: Text("View Targets", style: TextStyle()),
                          ),
                          Spacer(),
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
                      widget.signal.comment != '' ?
                        Text(
                          widget.signal.comment,
                          style: TextStyle(height: 1.5),
                        ) : Row(children: [Text(getStatusText(widget.signal))]),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
    if (signal.isTakeProfit3Hit) return _buildStatusContainer(text: 'Target 3', isProfit: true);
    if (signal.isTakeProfit2Hit) return _buildStatusContainer(text: 'Target 2', isProfit: true);
    if (signal.isTakeProfit1Hit) return _buildStatusContainer(text: 'Target 1', isProfit: true);
    if (signal.isStopLossHit) return _buildStatusContainer(text: 'Stop Loss', isProfit: false);
    return _buildStatusContainer(text: 'In progress', isProfit: true, isInProgress: true);
  }
}


_buildStatusContainer({required String text, required bool isProfit, bool isInProgress = false}) {
  if (isInProgress)
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: appColorBlue.withOpacity(.10)),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Text(text, style: TextStyle(color: appColorBlue, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isProfit ? Color(0xFF12533B).withOpacity(.6) : Color(0XFF332229),
    ),
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Row(
      children: [
        Text(text, style: TextStyle(color: isProfit ? Colors.white : Color(0xFFFF637E), fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(width: 4),
        Icon(isProfit ? Icons.check : Icons.close, color: Colors.white, size: 12),
      ],
    ),
  );
}
