// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:my_app_test/ContatoSobre.dart';
import 'package:my_app_test/Controle/ControlerClasses.dart';
import 'package:my_app_test/DataPacotes.dart';
import 'package:my_app_test/DestinosPage.dart';
import 'package:my_app_test/FinalizarPage.dart';
import 'MainPage.dart';
import 'Controle/GerarDados.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    GerarDadosTeste();
    return MaterialApp(
      initialRoute: "/Main",
      routes: {
        "/Main": (context) => MainPage(),
        "/Destinos": (context) => DestinosPage(),
        "/Pacotes": (context) => DataPacotes(),
        "/Finish": (context) => FinishPage(),
        "/CnttSobr": (context) => ContatoSobrePage()
      },
    );
  }
}
