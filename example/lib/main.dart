import 'package:flutter/material.dart';

import 'package:kakaonavi/kakaonavi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Flutter Demo Home Page'),
        // ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: KakaonaviView(),
        ),
      ),
    );
  }
}
