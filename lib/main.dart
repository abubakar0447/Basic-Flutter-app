import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> weatherData = {};

  void fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?appid=7acc39907655fc09d988b24106475ff1&q=Islamabad'));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      setState(() {
        weatherData = {'error': 'Failed to fetch weather data'};
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // Fetch weather data when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: weatherData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: weatherData.entries.map((entry) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${entry.key}: ${entry.value}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
