import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../worker/worker.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? temp;
  String? hum;
  String? airSpeed;
  String? desc;
  String? main;
  String? icon;
  String city = "Lucknow";

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    airSpeed = instance.airSpeed;
    desc = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'temp_value': temp,
        'hum_value': hum,
        'air_speed_value': airSpeed,
        'des_value': desc,
        'main_value': main,
        'icon_value': icon,
        'city_name': city,
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? search =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (search != null && search.isNotEmpty) {
      city = search['searchText'];
    }

    startApp(city);

    return Scaffold(
      body:  SingleChildScrollView(
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Image(image: AssetImage("assets/mlogo.png"), height: 240, width: 240),
              Text(
                "SkyCast",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Made By Prateek",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                height: 45,
              ),
              SpinKitSpinningLines(
                color: Colors.blueAccent,
                size: 80.0,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
