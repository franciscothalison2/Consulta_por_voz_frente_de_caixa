import 'package:app_pao_de_acuca/teste.dart';
import 'package:flutter/material.dart';
import 'package:app_pao_de_acuca/pages/home.dart';




main(){
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Módulos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
