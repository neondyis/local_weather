import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart';

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
  static const List<String> _cityNames = ['Deventer', 'Apeldoorn', 'Enschede'];

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getWeather(context, wf));
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
            padding: const EdgeInsets.only(top: 0.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Amsterdam",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 2, child: HomeBottom()),
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

getWeather(BuildContext context, WeatherFactory wf) async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  Weather weather = await wf.currentWeatherByLocation(
      _locationData.latitude!, _locationData.longitude!);
  print(weather);
}

class HomeBottom extends StatelessWidget {
  const HomeBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          // margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: CurveButton()),
    );
  }
}

class CurveButton extends StatelessWidget {
  const CurveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.all(24)),
        child: IconButton(
          icon: const Icon(Icons.add),
          color: Colors.black.withOpacity(0.5),
          onPressed: () {},
        ));
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
