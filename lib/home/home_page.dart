import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'curve_sectioner.dart';

class WeatherHomePage extends StatefulWidget {
  WeatherHomePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  int _selectedIndex = 0;
  WeatherFactory wf = new WeatherFactory('3bcedd8fd983c097abd4899a78961b7f',
      language: Language.ENGLISH);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<String> _cityNames = ['Deventer', 'Apeldoorn', 'Enschede'];
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: new List.generate(
                _cityNames.length,
                (index) => new ListTile(
                      title: Text('${_cityNames[index]}'),
                      onTap: () async {
                        Weather w = await wf
                            .currentWeatherByCityName('${_cityNames[index]}');
                        print(w);
                        Locale myLocale = Localizations.localeOf(context);
                        print(myLocale);
                      },
                    )),
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Welcome to the weather app, ${_cityNames.elementAt(_selectedIndex)}',
            style: TextStyle(fontSize: 15, color: Colors.amber),
          ),
        ),
        body: CustomPaint(
          painter: CurvePainter(),
          child: Container(),
        ),
      ),
    );
  }
}
