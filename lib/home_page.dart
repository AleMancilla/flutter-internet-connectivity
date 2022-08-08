import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reachability/flutter_reachability.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ActiveConnection = false;
  String T = "";

  String _networkStatus = 'Unknown';
  late StreamSubscription<NetworkStatus> subscription;

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
    _listenNetworkStatus();
    super.initState();
  }

  _listenNetworkStatus() async {
    if (Platform.isAndroid) {
      await Permission.phone.request();
    }
    subscription = FlutterReachbility().onNetworkStateChanged.listen((event) {
      setState(() {
        _networkStatus = "${event}";
      });
    });
  }

  // _currentNetworkStatus() async {
  //   if (Platform.isAndroid) {
  //     await Permission.phone.request();
  //   }
  //   NetworkStatus status = await FlutterReachbility().currentNetworkStatus();
  //   switch (status) {
  //     case NetworkStatus.unreachable:
  //     //unreachable
  //     case NetworkStatus.wifi:
  //     //wifi
  //     case NetworkStatus.mobile2G:
  //     //2g
  //     case NetworkStatus.moblie3G:
  //     //3g
  //     case NetworkStatus.moblie4G:
  //     //4g
  //     case NetworkStatus.moblie5G:
  //     //5h
  //     case NetworkStatus.otherMoblie:
  //     //other
  //   }
  //   setState(() {
  //     _networkStatus = status.toString();
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
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
              child: const Text("Check")),
          Text('Running on: $_networkStatus\n'),
        ],
      ),
    );
  }
}
