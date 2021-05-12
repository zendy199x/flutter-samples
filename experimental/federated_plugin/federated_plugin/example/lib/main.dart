// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:federated_plugin/federated_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

/// Demonstrates how to use the getBatteryLevel method from federated_plugin to retrieve
/// current battery level of device.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? batteryLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Federated Plugin Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            batteryLevel == null
                ? SizedBox.shrink()
                : Text(
                    'Battery Level: $batteryLevel',
                    style: Theme.of(context).textTheme.headline5,
                  ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await getBatteryLevel();
                  setState(() {
                    batteryLevel = result;
                  });
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text(
                        (error as PlatformException).message as String,
                      ),
                    ),
                  );
                }
              },
              child: Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
