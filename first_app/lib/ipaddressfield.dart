import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class IPAddressField extends StatelessWidget {
  final ipcontroller = new MaskedTextController(mask: '000.000.000.000');
  String ipAddress = "";
  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: ipcontroller,
      decoration: new InputDecoration(),
      onChanged: (text) {
        print("Text" + text);
        ipAddress = text;
      },
    );
  }
}
