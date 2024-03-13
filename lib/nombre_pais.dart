import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NombrePaisPage extends StatefulWidget {
  @override
  _NombrePaisPageState createState() => _NombrePaisPageState();
}

class _NombrePaisPageState extends State<NombrePaisPage> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  void _searchUniversities() async {
    String country = _countryController.text;
    if (country.isNotEmpty) {
      var response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _universities = data;
        });
      } else {
        print('Error en la solicitud HTTP: ${response.reasonPhrase}');
      }
    } else {
      print('Por favor, introduce el nombre de un país en inglés.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre País'),
      ),
      body: Container(
        color: Color.fromRGBO(44, 44, 68, 1),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'País (en inglés)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchUniversities,
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _universities[index]['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dominio: ${_universities[index]['domains'][0]}',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                          },
                          child: Text(
                            'Página web',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
