import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const apiKey='474c457a0c6adfa677928e327e4cd7e8';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    getLocationData();

    super.initState();
  }
  void getLocationData() async{
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial');

    var weatherData = await networkHelper.getWeatherData();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather:weatherData);
    }
    )
    );




  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.green,
          size: 100,
        ),
      ),
    );
  }
}
