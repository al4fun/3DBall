import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/xball_view.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: XBallView(
        mediaQueryData: MediaQuery.of(context),
        keywords: [
          "北京",
          "天津",
          "上海",
          "重庆",
          "河北",
          "山西",
          "辽宁",
          "吉林",
          "黑龙江",
          "江苏",
          "浙江",
          "安徽",
          "福建",
          "江西",
          "山东",
          "河南",
          "湖北",
          "湖南",
          "广东",
          "海南",
          "四川",
          "贵州",
          "云南",
          "陕西",
          "甘肃",
          "青海",
          "台湾",
          "内蒙古",
          "广西",
          "西藏",
          "宁夏",
          "新疆",
          "香港",
          "澳门",
        ],
        highlight: ["四川"],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
