import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:securityapp/Screens/Add_Device.dart';
import 'package:securityapp/Screens/Temp.dart';
import 'package:securityapp/Setting/Setting.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  late AudioPlayer _audioPlayer;

  List<String> addmenu = [
    'Scan QR Code',
    'Add Device Manually',
    'Online Device',
    'Add to Favorites',
    'Share Device'
  ];

  void Addmenulist(String choice) {
    switch (choice) {
      case 'Scan QR Code':
        // Navigate to Scan QR Code screen
        break;
      case 'Add Device Manually':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AddDeviceScreen()));
        break;
      case 'Online Device':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PaymentFailedScreen()));
        break;
      case 'Add to Favorites':
        // Add to favorites functionality
        break;
      case 'Share Device':
        // Share device functionality
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAlarm();
  }

  Future<void> _playAlarm() async {
    await _audioPlayer.play(DeviceFileSource('assets/love_ringtone.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: Addmenulist,
            itemBuilder: (BuildContext context) {
              return addmenu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Color(colorval), // Replace with your color value
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Device",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
