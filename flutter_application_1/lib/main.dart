import 'package:flutter/material.dart';
import 'home_screen.dart'; // HomeScreen을 가져옵니다.
import 'home_page.dart'; // HomePage를 가져옵니다.
import 'alarm_page.dart'; // AlarmPage를 가져옵니다.
import 'detail_information.dart'; // DetailInformation 페이지를 가져옵니다.
import 'live_connect.dart'; // LiveConnect 페이지를 가져옵니다.

// 백그라운드 메시지 핸들

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // 기본 색상 설정
        scaffoldBackgroundColor: Colors.white, // 배경 색상을 흰색으로 설정
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // AppBar 배경 색상을 흰색으로 설정
          iconTheme: IconThemeData(color: Colors.white), // AppBar 아이콘 색상 설정
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // AppBar 제목 텍스트 색상 및 크기 설정
        ),
      ),
      home: MyPage(),
      routes: {
        '/detail_information': (context) => DetailInformation(),
        '/live_connect': (context) => LiveConnect(),
      },
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'), // AppBar에 제목 추가
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlarmPage()),
              );
            },
          ),
        ],
      ),
      body: HomeScreen(),
    );
  }
}
