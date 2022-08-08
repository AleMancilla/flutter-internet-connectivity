import 'dart:io';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ActiveConnection = false;
  String T = "";
  // Future CheckUserConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     print('====> $result');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         ActiveConnection = true;
  //         T = "Turn off the data and repress again";
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     print('====> $_');
  //     setState(() {
  //       ActiveConnection = false;
  //       T = "Turn On the data and repress again";
  //     });
  //   }
  // }

  Future<bool> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      print('====> $result');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    checkUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GeeksforGeeks"),
      ),
      body: Column(
        children: [
          Text("Active Connection? $ActiveConnection"),
          const Divider(),
          Text(T),
          OutlinedButton(
              onPressed: () async {
                bool status = await checkUserConnection();
                print('==================>>>> $status');
              },
              child: const Text("Check"))
        ],
      ),
    );
  }
}
