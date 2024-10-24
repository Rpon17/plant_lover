import 'package:flutter/material.dart';

class LiveConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Connect'),
      ),
      body: Center(
        child: Text(
          '실시간 연동 페이지',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
