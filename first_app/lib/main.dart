import 'package:first_app/ipaddressfield.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(VikramsApp());
}

class VikramsApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VikramsAppState();
  }
}

class VikramsAppState extends State<VikramsApp> {
  IPAddressField ipAddressField;
  Widget build(BuildContext context) {
    this.ipAddressField = IPAddressField();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Vikrams App"),
            ),
            body: Column(
              children: [
                ipAddressField,
                Text("Display Address"),
                Text("Message"),
                RaisedButton(
                    child: Text('Send to device'),
                    onPressed: sendToDisplayDevice)
              ],
            )));
  }

  void sendToDisplayDevice() {
    print("Send to Device" + ipAddressField.ipAddress);

    Socket.connect("192.168.1.16", 5005).then((socket) {
      print("Sending message");
      socket.write("Testmessage");
      socket.destroy();
    });
  }
}
