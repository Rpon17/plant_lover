// home_screen.dart
import 'dart:convert'; // JSON 인코딩 및 디코딩을 위한 패키지
import 'dart:io'; // File 클래스 사용을 위해 추가
import 'package:flutter/material.dart'; // Flutter의 Material 디자인 위젯을 사용하기 위한 패키지
import 'package:image_picker/image_picker.dart'; // 이미지 선택을 위한 패키지
import 'package:http/http.dart' as http; // HTTP 요청을 위한 패키지
import 'package:file_selector/file_selector.dart'; // 파일 선택을 위한 패키지
import 'plant_item.dart'; // PlantItem 클래스 import
import 'home_page.dart'; // HomePage 클래스 import
import 'alarm_page.dart'; // AlarmPage 클래스 import
import 'plant_health.dart';

// MyPage 클래스 정의, StatelessWidget을 상속
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // 알림 아이콘 버튼
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AlarmPage()), // AlarmPage로 이동
              );
            },
          ),
        ],
      ),
      body: HomeScreen(), // HomeScreen 위젯을 body에 추가
    );
  }
}

// HomeScreen 클래스 정의, StatefulWidget을 상속
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState(); // HomeScreen의 상태를 관리할 State 클래스 생성
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlantItem> plantIcons = []; // 식물 아이템을 저장할 리스트
  bool isLoading = false; // 로딩 상태를 표시하는 변수

  // 식물 인식 API 호출 함수
  Future<void> identifyPlant(String imagePath) async {
    final String apiUrl = "https://api.plant.id/v2/identify"; // API URL
    final String apiKey = "Iq8DlsYg6ZUCfUsfM4CEFzasvSadkeQNU5OJ7TwC4Aq2JqaQW8"; // API 키

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl)); // POST 요청을 위한 MultipartRequest 생성
    request.files.add(await http.MultipartFile.fromPath('images', imagePath)); // 이미지 파일 첨부
    request.headers['Content-Type'] = 'application/json'; // 요청 헤더 설정
    request.headers['Api-Key'] = apiKey; // API 키 헤더 추가

    setState(() {
      isLoading = true; // 로딩 상태 변경
    });

    var response = await request.send(); // API 호출

    if (response.statusCode == 200) { // 응답 상태 코드가 200이면 성공
      final responseData = await response.stream.bytesToString(); // 응답 데이터 읽기
      final decodedResponse = jsonDecode(responseData); // JSON 디코드

      if (decodedResponse['suggestions'].isNotEmpty) { // 추천 결과가 있을 경우
        String plantName = decodedResponse['suggestions'][0]['plant_name']; // 첫 번째 추천 식물 이름 가져오기

        setState(() {
          plantIcons.add(PlantItem(
            plantName: plantName,      // 식물 이름 설정
            imagePath: imagePath,      // 이미지 경로 설정
            temperature: 100,          // 초기 온도 설정
            humidity: 100,             // 초기 습도 설정
            onDelete: () {             // 삭제 버튼 클릭 시 동작
              setState(() {
                plantIcons.removeWhere((item) => item.plantName == plantName); // 해당 식물 아이템 삭제
              });
            },
          ));
        });
      } else {
        print("No suggestions available."); // 추천 결과 없음
      }
    } else {
      print("Failed to identify plant."); // 식물 인식 실패
    }

    setState(() {
      isLoading = false; // 로딩 상태 변경
    });
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async { 
    String? deviceType = await showDialog<String>( // 디바이스 타입 선택 다이얼로그 표시
      context: context, 
      builder: (context) { 
        return AlertDialog( 
          title: Text('디바이스 타입을 선택하세요'), // 다이얼로그 제목
          content: Text('식물이 걸어오는중~'), // 다이얼로그 내용
          actions: [ 
            TextButton(onPressed: () => Navigator.pop(context, 'Phone'), child: Text('휴대폰')), // 휴대폰 선택 버튼
            TextButton(onPressed: () => Navigator.pop(context, 'Computer'), child: Text('컴퓨터')), // 컴퓨터 선택 버튼
          ],
        );
      },
    );

    if (deviceType == 'Phone') { // 선택한 디바이스가 휴대폰일 경우
      final ImagePicker picker = ImagePicker(); // 이미지 선택기 초기화
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery); // 갤러리에서 이미지 선택
      if (pickedFile != null) { // 선택된 파일이 있을 경우
        await identifyPlant(pickedFile.path); // 식물 인식 함수 호출
      }
    } else if (deviceType == 'Computer') { // 선택한 디바이스가 컴퓨터일 경우
      final XFile? pickedFile = await openFile(acceptedTypeGroups: [ // 파일 선택기 열기
        XTypeGroup(label: 'images', extensions: ['jpg', 'jpeg', 'png']), // 허용되는 이미지 타입
      ]);
      if (pickedFile != null) { // 선택된 파일이 있을 경우
        await identifyPlant(pickedFile.path); // 식물 인식 함수 호출
      }
    }
  }

  @override
Widget build(BuildContext context) {
  return Column( // 수직 방향으로 배치하는 Column 위젯
    crossAxisAlignment: CrossAxisAlignment.start, // 자식 위젯을 왼쪽 정렬
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0), // 여백 설정
        child: Row( // 가로 방향으로 배치하는 Row 위젯
          children: [
            IconButton(
              icon: Icon(Icons.home, size: 30), // 홈 아이콘 버튼
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // HomePage로 이동
                );
              },
            ),
            SizedBox(width: 8), // 여백 설정
            Text('Home', style: TextStyle(fontSize: 24)), // 텍스트 표시
          ],
        ),
      ),
      SizedBox(height: 40), // 여백 설정
      Expanded( // 남은 공간을 채우는 Expanded 위젯
        child: ListView( // 스크롤 가능한 리스트뷰
          children: [
            ...plantIcons, // 저장된 PlantItem 위젯을 리스트에 추가
            if (isLoading) // 로딩 상태일 경우
              Padding(
                padding: const EdgeInsets.all(16.0), // 여백 설정
                child: Center(child: CircularProgressIndicator()), // 로딩 인디케이터 표시
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0), // 여백 설정
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.add, size: 50), // 추가 아이콘 버튼
                  onPressed: _pickImage, // 이미지 선택 함수 호출
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
}