import 'package:flutter/material.dart';
import 'dart:io';
import 'plant_widget.dart'; // 새로운 PlantWidget 페이지를 가져옵니다.

class PlantItem extends StatelessWidget {
  final String plantName;
  final String imagePath;
  final int humidity;
  final int temperature;
  final VoidCallback onDelete;

  PlantItem({
    required this.plantName,
    required this.onDelete,
    required this.imagePath,
    this.humidity = 100,
    this.temperature = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantWidget(
              plantName: plantName,
              imageUrl: imagePath,
              humidity: humidity.toDouble(),
              temperature: temperature.toDouble(),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: 300,
        height: 200,
        color: Colors.white,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('습도: $humidity%', style: TextStyle(fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(plantName, style: TextStyle(fontSize: 16)),
                      ),
                      Text('온도: $temperature°C', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              child: IconButton(
                icon: Icon(Icons.remove, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
