import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flippo_navigation/flippo_navigation.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flippo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'GoogleSans'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key); // changed

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {

    return new Flippo(
      controller: controller,
      mask: new Scaffold(
        backgroundColor: Colors.white,
      ),
      body: new Scaffold(
        backgroundColor: Colors.white,
      ),
      drawer: new Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }
}