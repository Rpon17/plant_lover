import 'package:flutter/material.dart';

class PlantHealth extends StatefulWidget {
  @override
  _PlantHealthState createState() => _PlantHealthState();
}

class _PlantHealthState extends State<PlantHealth> {
  int humidity = 100; // 초기 습도 값
  int temperature = 100; // 초기 온도 값

  @override
  void initState() {
    super.initState();
    checkPlantHealth();
  }

  void checkPlantHealth() {
    // 습도와 온도가 10 이하일 때 알림
    if (humidity < 10) {
      sendAlert("습도가 너무 낮습니다: $humidity%");
    }

    if (temperature < 10) {
      sendAlert("온도가 너무 낮습니다: $temperature°C");
    }
  }

  void sendAlert(String message) {
    // 알림 전송 구현 필요
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Health'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('습도: $humidity%', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          Text('온도: $temperature°C', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
