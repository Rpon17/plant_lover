import 'package:flutter/material.dart'; // Flutter UI 패키지를 사용하기 위해 import
import 'dart:io'; // File 클래스를 사용하기 위해 추가

// PlantWidget 클래스 정의, StatelessWidget을 상속
class PlantWidget extends StatelessWidget {
  final String plantName; // 식물의 이름을 저장하는 변수
  final String imageUrl; // 이미지 파일 경로를 저장하는 변수
  final double humidity; // 습도를 저장하는 변수
  final double temperature; // 온도를 저장하는 변수

  // PlantWidget 생성자
  const PlantWidget({
    Key? key, // 키를 지정하여 위젯의 고유성을 보장
    required this.plantName, // 필수 입력값으로 식물 이름 지정
    required this.imageUrl, // 필수 입력값으로 이미지 경로 지정
    required this.humidity, // 필수 입력값으로 습도 지정
    required this.temperature, // 필수 입력값으로 온도 지정
  }) : super(key: key); // 부모 클래스인 StatelessWidget의 생성자 호출

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 화면을 구성하는 Scaffold 위젯
      appBar: AppBar( // 상단에 표시될 AppBar 위젯
        leading: IconButton( // 뒤로가기 버튼 추가
          icon: Icon(Icons.arrow_back), // 뒤로가기 화살표 아이콘
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
        title: Text(plantName), // AppBar의 제목으로 식물 이름 표시
      ),
      body: Padding( // 화면의 내용을 여백을 두고 배치하기 위한 Padding 위젯
        padding: const EdgeInsets.all(16.0), // 모든 방향으로 16.0의 여백 설정
        child: Column( // 위젯을 수직으로 배치하기 위한 Column 위젯
          crossAxisAlignment: CrossAxisAlignment.start, // 자식 위젯을 왼쪽으로 정렬
          children: [
            Center( // 이미지를 중앙에 배치하기 위한 Center 위젯
              child: Column(
                children: [
                  SizedBox(height: 5.0), // 이미지와 식물 이름 사이에 5.0의 여백 추가
                  Text( // 식물 이름을 표시하는 Text 위젯
                    '$plantName', // 식물 이름 표시
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // 텍스트 스타일 설정
                  ),
                  const SizedBox(height: 10.0), // 이미지와 식물 이름 사이의 간격 설정
                  Image.file(File(imageUrl)), // 이미지 파일 경로를 사용해 이미지를 표시
                ],
              ),
            ),
            const SizedBox(height: 20), // 이미지와 텍스트 사이에 20의 여백 추가
            Text( // 습도를 표시하는 Text 위젯
              'Humidity: ${humidity.toStringAsFixed(1)}%', // 습도 값을 소수점 첫째 자리까지 표시
              style: TextStyle(fontSize: 18), // 텍스트 스타일 설정
            ),
            const SizedBox(height: 10), // 텍스트 간 10의 여백 추가
            Text( // 온도를 표시하는 Text 위젯
              'Temperature: ${temperature.toStringAsFixed(1)}°C', // 온도 값을 소수점 첫째 자리까지 표시
              style: TextStyle(fontSize: 18), // 텍스트 스타일 설정
            ),
            const SizedBox(height: 20), // 습도와 온도 아래에 20의 여백 추가
            Row( // 두 개의 버튼을 좌우로 배치하기 위한 Row 위젯
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 좌우로 간격을 두고 배치
              children: [
                ElevatedButton( // 실시간연동 버튼
                  onPressed: () {
                    Navigator.pushNamed(context, '/live_connect'); // 실시간 연동 기능 페이지로 이동
                  },
                  child: Text('실시간연동'), // 버튼에 표시될 텍스트
                ),
                ElevatedButton( // 상세정보 버튼
                  onPressed: () {
                    Navigator.pushNamed(context, '/detail_information'); // 상세 정보 페이지로 이동
                  },
                  child: Text('상세정보'), // 버튼에 표시될 텍스트
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
