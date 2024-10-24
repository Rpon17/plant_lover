// alarm_page.dart
import 'package:flutter/material.dart';

class AlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
        actions: [
          IconButton(
            icon: Text("MAIN", style: TextStyle(fontSize: 16)),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          '알람',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
