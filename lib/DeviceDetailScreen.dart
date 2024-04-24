import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;

  DeviceDetailScreen({
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    final dbRef =
        FirebaseDatabase.instance.ref().child("microcontroleur/$deviceId");

    return Scaffold(
      appBar: AppBar(
        title: Text('Device Detail: $deviceId'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: dbRef.onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                Map<dynamic, dynamic> deviceData = Map<dynamic, dynamic>.from(
                    snapshot.data!.snapshot.value as Map);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCircleProgress('Temperature',
                        deviceData['temperature'] ?? 0, Colors.red),
                    SizedBox(height: 20),
                    buildCircleProgress(
                        'Humidity', deviceData['humidity'] ?? 0, Colors.blue),
                    SizedBox(height: 20),
                    buildCircleProgress(
                        'Gas', deviceData['gaz'] ?? 0, Colors.green),
                    SizedBox(height: 20),
                    buildCircleProgress(
                        'Moisture', deviceData['moisture'] ?? 0, Colors.orange),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCircleProgress(String label, num value, Color color) {
    return Container(
      height: 200,
      width: 200,
      child: CustomPaint(
        foregroundPainter: CircleProgress(value, color),
        child: Center(
          child: Text(
            '$label: ${value.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
  num value;
  Color color;

  CircleProgress(this.value, this.color);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint progressArc = Paint()
      ..strokeWidth = 14
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      progressArc,
    );
  }
}
