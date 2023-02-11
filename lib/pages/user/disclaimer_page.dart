import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insigh/components/z_button.dart';
import 'package:insigh/components/z_text_form_field.dart';
import 'package:insigh/models/support.dart';
import 'package:provider/provider.dart';

import '../../models/app_control_disclaimer.dart';
import '../../models_providers/app_provider.dart';
import '../../models_services/api_support_service.dart';
import '../../models_services/firestore_service.dart';
import '../../utils/z_utils.dart';
import '../../utils/z_validators.dart';

class DisclaimerPage extends StatefulWidget {
  DisclaimerPage({Key? key}) : super(key: key);

  @override
  State<DisclaimerPage> createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.transparent, title: Text('Disclaimer')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('"InsighTrading app is for informational purposes only and does not guarantee the accuracy, completeness, or timeliness of the information provided. We will not be liable for any loss or damage caused by reliance on the information provided. The app and its content are provided on an "as is" basis.\n\nTrading in securities and other financial instruments carries inherent risks and is not suitable for all investors. The user should carefully consider his or her own financial situation and consult a financial advisor before making any investment decisions.\n\nPlease note : We are not registered with the Securities and Exchange Board of India (SEBI) and user acknowledges the same before proceeding. By using this app, the user acknowledges and agrees to the terms of this disclaimer."', style: TextStyle(fontSize: 14),),
      )
    );
  }

}
