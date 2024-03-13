import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcercaDePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(44, 44, 68, 1),
      ),
      body: Center(
        child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromRGBO(44, 44, 68, 1), Color.fromRGBO(4, 187, 163, 1)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
            ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              'Gexiel Moises',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
              SizedBox(height: 20),
              Image.asset(
                'assets/ME.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 30),
              Text(
                'Matrícula: 2021/2287',
                style: GoogleFonts.aDLaMDisplay(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(44, 44, 68, 1))),
              ),
              Text(
                'Gmail: 20212287@itla.edu.do',
                style: GoogleFonts.aDLaMDisplay(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(44, 44, 68, 1))),
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
