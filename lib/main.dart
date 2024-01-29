import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MethodChannel platformChannel = const MethodChannel("example/channel");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ElevatedButton(
              onPressed: (){
             fetchDataFromNative();
              },
             child: const  Text("click"),
           )
          ],
        ),
      )
    );
  }
  Future fetchDataFromNative()async{
    try{
    Map argument =  {"name":"vijay"};
      final String result = await platformChannel.invokeMethod("getDataFromNative",argument);
    print('Result from Native: $result');
    } on PlatformException catch(e){
      print('Error: ${e.message}');
    }
  }
}

