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
        drawer: SafeArea(
          child: Drawer(
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
        ),
        appBar: AppBar(
          title: Text(
            'Welcome to the weather app, ${_cityNames.elementAt(_selectedIndex)}',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.red[500],
                          child: Row(
                            children: <Widget>[CurvedWidget()],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: new EdgeInsets.symmetric(
                                          horizontal: 60.0, vertical: 13.0),
                                      child: TextButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              onPrimary: Colors.white,
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(24)),
                                          child: Text('lol')),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class CurvedWidget extends StatelessWidget {
  const CurvedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: CurvePainter(),
            size: Size(MediaQuery.of(context).size.width.toDouble(),
                (MediaQuery.of(context).size.height * 0.3).toDouble()),
          ),
        ),
      ],
    );
  }
}
