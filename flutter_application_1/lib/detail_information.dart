import 'package:flutter/material.dart';

class DetailInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Connect'),
      ),
      body: Center(
        child: Text(
          '상세정보',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
