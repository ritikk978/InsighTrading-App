import 'package:flutter/material.dart';
import 'package:insigh/models/advance_decline.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';

class AdvanceDeclineView extends StatelessWidget {
  List<AdvanceDeclineModelData> advanceDecline;
  AdvanceDeclineView(this.advanceDecline);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: appColorDarkBlue,
        title: Text('Advance/Decline'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-84,
                child: advanceDecline.isNotEmpty
                    ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: advanceDecline.length,
                          itemBuilder:
                              (BuildContext context, int index) =>
                              Card(
                                  color: appColorDarkBlue,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Center(
                                          child: Text(
                                              advanceDecline[index]
                                                  .indice ?? '',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.topCenter,
                                          margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                          child: LinearProgressIndicator(
                                            backgroundColor: Colors.red,
                                            valueColor:
                                            AlwaysStoppedAnimation<
                                                Color>(Colors.green),
                                            value: (double.parse(
                                                advanceDecline[
                                                index]
                                                    .advances ?? '0') /
                                                (double.parse(advanceDecline[
                                                index]
                                                    .declines ?? '0') +
                                                    double.parse(
                                                        advanceDecline[
                                                        index]
                                                            .advances ?? '0'))),
                                          )),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Text(
                                                advanceDecline[index]
                                                    .advances ?? '0',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold, color: Colors.green)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 150.0, bottom: 10),
                                            child: Text(
                                                advanceDecline[index]
                                                    .declines ?? '0',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold, color: Colors.red)),
                                          ),
                                        ],)

                                    ],
                                  )),
                        ),
                      ),
                    ),

                    // Positioned(
                    //   bottom: 5,
                    //   left: 0,
                    //   right: 0,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: topGainersProvider.topGainersList.map((banner) {
                    //       int index = topGainersProvider.topGainersList.indexOf(banner);
                    //       return TabPageSelectorIndicator(
                    //         backgroundColor: index == topGainersProvider.topGainersSelectedIndex ? Theme.of(context).primaryColor : Colors.grey,
                    //         borderColor: index == topGainersProvider.topGainersSelectedIndex ? Theme.of(context).primaryColor : Colors.grey,
                    //         size: 10,
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                )
                    : Center(child: Text('No Ratio available'))
              ),
            )
          ],
        ),
      ),
    );
  }
}
