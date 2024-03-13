import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredecirGeneroPage extends StatefulWidget {
  @override
  _PredecirGeneroPageState createState() => _PredecirGeneroPageState();
}

class _PredecirGeneroPageState extends State<PredecirGeneroPage> {
  TextEditingController _nameController = TextEditingController();
  String _predictedGender = '';
  Color _backgroundColor = Color.fromRGBO(44, 44, 68, 1);

  void _predictGender() async {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      var response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _predictedGender = data['gender'];
          _backgroundColor = (_predictedGender == 'male') ? Colors.blue : const Color.fromARGB(255, 217, 64, 115);
        });
      } else {
        print('Error en la solicitud HTTP: ${response.reasonPhrase}');
      }
    } else {
      print('Por favor, introduce un nombre.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir Género'),
      ),
      body: Container(
        color: _backgroundColor,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(4, 187, 163, 1)),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictGender,
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            Text(
              (_predictedGender.isNotEmpty)
                  ? (_predictedGender == 'male' ? 'Predicción: Masculino' : 'Predicción: Femenino')
                  : '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
