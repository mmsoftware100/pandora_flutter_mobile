import 'package:flutter/material.dart';
import 'package:pandora_flutter_mobile/view/widgets/terms_and_condition_widget.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Terms and condition"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TermsAndConditionWidget(),
          )),
    );
  }
}
