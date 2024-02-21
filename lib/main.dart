import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todo_provider.dart';

import 'home/home.dart';

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>TodoProvider()),
  ],child: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      home: HomePage(),
    );
  }
}
