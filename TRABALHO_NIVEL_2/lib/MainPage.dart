// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Controle/ControlerClasses.dart';
import 'package:google_fonts/google_fonts.dart';
import '/Components/HeaderBar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              HeaderBar(),
              SizedBox(
                width: maxWidth - (maxWidth > 1000 ? 200 : 50),
                child: Column(
                  children: [
                    Text("Bem-vindo à Explore Mundo!",
                        style: GoogleFonts.irishGrover(
                          textStyle: const TextStyle(
                            fontSize: 25,
                          ),
                        )),
                    Text(
                      maxWidth > 700 ? TextoGrande : TextoCel,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
