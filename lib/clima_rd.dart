import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClimaRdPage extends StatefulWidget {
  @override
  _ClimaRDPageState createState() => _ClimaRDPageState();
}

class _ClimaRDPageState extends State<ClimaRdPage> {
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    String apiKey = '34a97794f920e3b4ef3e6eafcd26ee58';
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=Republic%20Dominicana&APPID=$apiKey&units=metric';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
      });
    } else {
      print('Error en la solicitud HTTP: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima RD'),
      ),
      body: Container(
        color: Color.fromRGBO(44, 44, 68, 1),
        padding: EdgeInsets.all(20.0),
        child: _weatherData != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temperatura: ${_weatherData!['main']['temp']} °C',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Descripción: ${_weatherData!['weather'][0]['description']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Velocidad del viento: ${_weatherData!['wind']['speed']} m/s',
                    style: TextStyle(color: Colors.white),
                  ),
                  // Agrega más información del clima si lo deseas
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
