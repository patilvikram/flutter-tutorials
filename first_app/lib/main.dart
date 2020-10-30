import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var context;

  @override
  void dispose() {
    messageFieldController.dispose();
    portFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    this.context = context;
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

  void sendToDisplayDevice() async {
    print("Send to Device" +
        ipAddressFieldController.text +
        " " +
        messageFieldController.text +
        " " +
        portFieldController.text);

    // Duration socketConnectionTimeout = new Duration(seconds: 5);
    // Socket.connect(
    //   ipAddressFieldController.text,
    //   int.parse(portFieldController.text),

    // ).then((socket) {
    //   print("Sending message");
    //   socket.write("Testmessage");
    //   socket.flush();
    //   socket.destroy();
    // }).catchError((e) {
    //   print("ASDAS" + e.error);
    //   _showToast(context);
    // });

    try {
      Socket deviceSocket = await Socket.connect(
          ipAddressFieldController.text, int.parse(portFieldController.text));

      deviceSocket.write(messageFieldController.text);

      deviceSocket.flush();
      deviceSocket.destroy();
    } catch (e) {
      print(e);
      _showToast(context);
    }
  }

  void _showToast(BuildContext context) {}
}
