import 'package:first_app/ipaddressfield.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() {
  runApp(DisplayApp());
}

class DisplayApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DisplayAppState();
  }
}

class DisplayAppState extends State<DisplayApp> {
  TextField ipAddressField;
  TextField portField;
  TextField messageField;
  final messageFieldController = TextEditingController();
  final portFieldController = TextEditingController();
  final ipAddressFieldController = TextEditingController();

  @override
  void dispose() {
    messageFieldController.dispose();
    portFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    this.ipAddressField = TextField(
        decoration: new InputDecoration(labelText: "IP Address"),
        keyboardType: TextInputType.number,
        controller: ipAddressFieldController);
    this.portField = new TextField(
      decoration: new InputDecoration(labelText: "PORT"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: portFieldController,
    );
    this.messageField = new TextField(
        decoration: InputDecoration(labelText: "Enter your message to display"),
        controller: messageFieldController);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("LED Display controller"),
            ),
            body: Column(
              children: [
                ipAddressField,
                portField,
                messageField,
                RaisedButton(
                    child: Text('Send to device'),
                    onPressed: sendToDisplayDevice)
              ],
            )));
  }

  void sendToDisplayDevice() {
    print("Send to Device" +
        ipAddressFieldController.text +
        " " +
        messageFieldController.text +
        " " +
        portFieldController.text);

    Socket.connect(
            ipAddressFieldController.text, int.parse(portFieldController.text))
        .then((socket) {
      print("Sending message");
      socket.write("Testmessage");
      socket.destroy();
    });
  }
}
