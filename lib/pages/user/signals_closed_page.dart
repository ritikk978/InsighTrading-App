import 'package:flutter/material.dart';
import 'package:insigh/components/z_signal_closed_card.dart';
import 'package:insigh/models_services/firestore_service.dart';

import '../../models/signal.dart';

class SignalsClosedPage extends StatefulWidget {
  SignalsClosedPage({Key? key}) : super(key: key);

  @override
  State<SignalsClosedPage> createState() => _SignalsClosedPageState();
}

class _SignalsClosedPageState extends State<SignalsClosedPage> {
  bool isInitLoading = true;
  List<Signal> signals = [];

  @override
  void initState() {
    getSignals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Closed Insights')),
      body: getBody(),
    );
  }

  getBody() {
    if (isInitLoading) return Center(child: CircularProgressIndicator());
    if (signals.isEmpty) return Center(child: Text('No Closed Insights Yet!'));

    return ListView.builder(
      itemCount: signals.length,
      itemBuilder: (context, index) {
        return ZSignalClosedCard(signal: signals[index]);
      },
    );
  }

  void getSignals() async {
    signals = await FirestoreService.getSignalsClosed();
    isInitLoading = false;
    setState(() {});
  }
}
