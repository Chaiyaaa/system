import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
// Import HomeView
import 'DeviceDetailScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Configure the initialization settings
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );
  // Initialize the plugin with the initialization settings
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
// Replace with actual values
      options: FirebaseOptions(
    apiKey: 'AIzaSyCzyF7weQteGefPCCYiKk0gEtk4ECox_ec',
    appId: '1:5048789483:android:fe7602d66fc373fed4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Splash",
      home: SplashScreenPage(),
    );
  }
}

// First screen --- Splash Screen Page
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 10);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 121, 135),
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          width: 200.0,
          height: 100.0,
        ),
      ),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Data Viewer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ESP32 Devices Data'),
        ),
        body: DeviceList(),
      ),
    );
  }
}

class DeviceList extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.ref().child("microcontroleur");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void _getToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      assert(token != null);
      String msg = "Push Messaging token: $token";
      print(msg);

      // Store the FCM token in the Firebase Realtime Database
      FirebaseDatabase.instance.ref("fcm-token/$token").set({"token": token});

      // Displaying the token using FlutterToast
    }).catchError((e) {
      print("Error fetching the FCM token: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.requestPermission();
    _getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle notification when the app is in the foreground
      print("onMessage: ${message.data}");

      // Check if the message contains data for temperature alert
      if (message.data['title'] == 'Temperature Alert!') {
        // Display a notification to the user
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
        );
        final NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          'Temperature Alert!',
          'Temperature is greater than 23 for device ${message.data['deviceId']}.',
          platformChannelSpecifics,
          payload: 'item x',
        );
      }
    });
    return StreamBuilder(
      stream: dbRef.onValue,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData &&
            !snapshot.hasError &&
            snapshot.data!.snapshot.value != null) {
          Map<dynamic, dynamic> data =
              Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as Map);

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: data.keys.map<Widget>((deviceId) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeviceDetailScreen(
                            deviceId: deviceId,
                          ),
                        ),
                      );
                    },
                    child: buildDeviceCard(deviceId),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildDeviceCard(String deviceId) {
    String imagePath = 'assets/$deviceId.jpg';
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Card(
        color: Colors
            .transparent, // Make the card transparent to show the background image
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(50),
              child: Text(deviceId,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
