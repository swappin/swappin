import 'package:flutter/material.dart';
import 'package:swappin/src/ui/historic.dart';
import 'package:swappin/src/ui/notifications.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Tabs Example'),
          ),
          body: TabBarView(
            children: [
              NotificationScreen(),
              HistoricScreen(),
            ],
          ),
        ),
      ),
    );
  }
}