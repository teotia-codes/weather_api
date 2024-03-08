import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_api/const.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 final WeatherFactory _wf = WeatherFactory(apikey);
 Weather? weather;
 @override
  void initState() {
       super.initState();
       _wf.currentWeatherByCityName("Delhi").then((w){
         setState(() {
           weather = w;
         });
       });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
   appBar: AppBar(),
         body: SingleChildScrollView(child: _buildUI()),
      ); 
  }
  Widget _buildUI(){
    if(weather == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _locationHeader(),
         SizedBox(
            height: MediaQuery.sizeOf(context).height *0.08,
          ),
          dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          _currTemp(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
            _extraInfo(),
        ],
      ),
    );
  }
Widget _locationHeader(){
 return Text(weather?.areaName ?? "",
 style: GoogleFonts.lato(
  fontWeight:FontWeight.bold,
  fontSize:26
 ),);
}
Widget dateTimeInfo(){
  DateTime now = weather!.date!;
  return Column(
    children: [Text(DateFormat("h:mm a").format(now),
    style: GoogleFonts.lato(
      fontSize: 35,
      fontWeight: FontWeight.w400
    ),),
    const SizedBox(height: 10,),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(DateFormat("EEEE").format(now),
    style: GoogleFonts.lato(
      fontSize: 25,
      fontWeight: FontWeight.w700
    ),),
    Text("  ${DateFormat("d-M-y").format(now)}",
    style: GoogleFonts.lato(
      fontSize:18,
     
    ),),
    ],)
    ],
  );
}
Widget _weatherIcon() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
       height: MediaQuery.sizeOf(context).height * 0.20,
       decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"),
        ),
       ),
      ),
      Text(
        weather?.weatherDescription ?? "" ,
        style: GoogleFonts.lato(
          color:Colors.black,
          fontSize: 20
        ),
      )
    ],
  );
}
Widget _currTemp(){
return Text("${weather?.temperature?.celsius?.toStringAsFixed(0)} °C",
style: GoogleFonts.lato(
  color:Colors.black,
  fontSize:90,
  fontWeight: FontWeight.w500
),);
}
Widget _extraInfo() {
  return Container(
    width: 350,
    height: 180,
   
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    gradient: LinearGradient(colors: [
    Color(0xFFaccbee),
    Color(0xFFe7f0fd)],
    ),
    
  ),
  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Max: ${weather?.tempMax?.celsius?.toStringAsFixed(0)} °C",
      style: GoogleFonts.lato(
        color: Colors.blue.shade900,
        fontSize: 18
      ),),
      Text("Min: ${weather?.tempMin?.celsius?.toStringAsFixed(0)} °C",
      style: GoogleFonts.lato(
        color: Colors.blue.shade900,
        fontSize: 18
      ),)
    ],
    ),
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Wind: ${weather?.windSpeed?.toStringAsFixed(0)} m/s",
      style: GoogleFonts.lato(
        color: Colors.blue.shade900,
        fontSize: 18
      ),),
      Text("Humidity: ${weather?.humidity?.toStringAsFixed(0)}%",
      style: GoogleFonts.lato(
        color: Colors.blue.shade900,
        fontSize: 18
      ),)
    ],
    )
  ],),
  );
}
}
