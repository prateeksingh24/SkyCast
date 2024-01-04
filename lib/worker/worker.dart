import 'dart:convert';

import 'package:http/http.dart' as http;

class worker {
  String? location;
  //constructor
  worker({this.location})
  {
    location = this.location;
  }


  String? temp;
  String? humidity;
  String? airSpeed;
  String? description;
  String? main;
  String? icon;
  String apiKey="";


  //method
  Future <void> getData() async{
    try{
      http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey"));
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidity
      Map tempData = data["main"];
      double getTemp = tempData['temp']-273.15;
      int getHumidity = tempData['humidity'];

      //Getting air speed
      Map wind = data['wind'];
      double getAirSpeed = wind['speed']/0.2777777777777778;

      //Getting Description,main
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getMainDesc = weatherMainData['main'];
      String getDesc = weatherMainData['description'];
      String getIcon = weatherMainData['icon'];



      //Assigning Value
      temp = getTemp.toString();//C
      humidity = getHumidity.toString();//%
      airSpeed = getAirSpeed.toString();//km/hr
      description = getDesc;
      main = getMainDesc;
      icon = getIcon;

    }
    catch(e)
    {
      temp = "NA";
      humidity = "NA";
      airSpeed = "NA";
      description = "Can't Find Data";
      main = "NA";
      icon = "09d";

    }




  }


}



