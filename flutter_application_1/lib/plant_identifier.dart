import 'dart:convert'; // JSON 인코딩과 디코딩을 위해 필요
import 'dart:io'; // File 클래스를 사용하기 위해 필요
import 'package:flutter/material.dart'; // Flutter UI 패키지
import 'package:http/http.dart' as http; // http 패키지 import
import 'package:image_picker/image_picker.dart'; // 이미지 선택을 위한 패키지
import 'package:permission_handler/permission_handler.dart'; // 권한 요청을 위한 패키지

class PlantIdentifier extends StatefulWidget {
  @override
  _PlantIdentifierState createState() => _PlantIdentifierState();
}

class _PlantIdentifierState extends State<PlantIdentifier> {
  String? _result; // 식별 결과 저장
  final picker = ImagePicker(); // ImagePicker 인스턴스 생성

  Future<void> _identifyPlant(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      String base64Image = base64Encode(bytes);
      
      final response = await http.post(
        Uri.parse('https://api.plant.id/v2/identify'),
        headers: {
          "Content-Type": "application/json",
          "Api-Key": "Iq8DlsYg6ZUCfUsfM4CEFzasvSadkeQNU5OJ7TwC4Aq2JqaQW8", // 여기에 API 키 추가
        },
        body: jsonEncode({
          "images": [base64Image],
          "organs": ["leaf"], // 필요한 경우 수정
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _result = responseData['suggestions'] != null
              ? responseData['suggestions'].map((suggestion) => suggestion['commonNames']).join(', ')
              : 'No suggestions found.';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}'; // 에러 처리
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error reading file: $e'; // 파일 읽기 에러 처리
      });
    }
  }

  Future<void> _pickImage() async {
    // 권한 요청
    if (await Permission.storage.request().isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        await _identifyPlant(pickedFile.path); // 선택한 이미지로 식별 호출
      }
    } else {
      setState(() {
        _result = 'Storage permission denied'; // 권한 거부 처리
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Upload Image'),
        ),
        if (_result != null) ...[
          SizedBox(height: 16),
          Text('Result: $_result'), // 결과 표시
        ],
      ],
    );
  }
}

