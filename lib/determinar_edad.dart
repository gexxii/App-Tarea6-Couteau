import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeterminarEdadPage extends StatefulWidget {
  @override
  _DeterminarEdadPageState createState() => _DeterminarEdadPageState();
}

class _DeterminarEdadPageState extends State<DeterminarEdadPage> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  String _imagePath = '';

  void _determineAge() async {
    String name = _nameController.text;
    if (name.isNotEmpty) {
      var response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _age = data['age'];
          if (_age <= 25) {
            _ageGroup = 'Joven';
            _imagePath = 'assets/joven.png';
          } else if (_age <= 60) {
            _ageGroup = 'Adulto';
            _imagePath = 'assets/adulto.png';
          } else {
            _ageGroup = 'Anciano';
            _imagePath = 'assets/anciano.png';
          }
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
        title: Text('Determinar Edad'),
      ),
      body: Container(
        color: Color.fromRGBO(44, 44, 68, 1),
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
                  borderSide: BorderSide(color: Color.fromRGBO(4, 187, 163, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _determineAge,
              child: Text('Determinar Edad', style: TextStyle(color: Color.fromRGBO(44, 44, 68, 1)),),
            ),
            SizedBox(height: 20),
            if (_age != 0)
              Column(
                children: [
                  Text(
                    'Edad: $_age',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Grupo de edad: $_ageGroup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    _imagePath,
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
