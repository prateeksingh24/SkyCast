import 'package:flutter/material.dart'; // Import for Flutter UI components
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart'; // Import for making HTTP requests

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Declare variables here if needed
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // final _random = new Random();
    // var city = cityName[_random.nextInt(cityName.length)];

    // Access arguments passed from a previous route (if any)
    final Map<String, dynamic>? info =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
     String temp = (info?["temp_value"]?? 'No Data');
     String iconCode = info?["icon_value"]?? 'No Data' ;
     String getCity = info?["city_name"]?? 'No Data' ;
     String hum = info?["hum_value"]?? 'No Data' ;
     String air = (info?["air_speed_value"]?? 'No Data' );
     String desc = info?["des_value"]?? 'No Data' ;
    if (temp.length >= 4) {
      temp = temp.substring(0, 4);
    }

    if (air.length >= 4) {
      air = air.substring(0, 4);
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: const LinearGradient(
            colors: [
              Colors.blue,
              Color(0xff90CAF9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  // Color(0xff8EC5FC),
                  // Color(0xffE0C3FC),
                  Color(0xff1565C0),
                  Color(0xff64B5F6),
                ])),
            child: Column(
              children: [
                //Search Container
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white60,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") == "")
                            {
                              print("Blank Search");
                            }
                          else
                            {
                              Navigator.pushReplacementNamed(context, '/loading',
                                  arguments: {
                                    "searchText" : searchController.text,
                                  });
                            }
        
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                            child: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            )),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onEditingComplete: (){
                            if((searchController.text).replaceAll(" ", "") == "")
                            {
                              print("Blank Search");
                            }
                            else
                            {
                              Navigator.pushReplacementNamed(context, '/loading',
                                  arguments: {
                                    "searchText" : searchController.text,
                                  });
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Search Your City....... "),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child:  Row(
                          children: [
                            Image.network('https://openweathermap.org/img/wn/$iconCode@2x.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$desc",
                                  style:  const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "In $getCity",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 210,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin:
                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                 Icon(WeatherIcons.thermometer,),
                                SizedBox(
                                  width:10 ,
                                ),
                                Text("Temprature",style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                ),)
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp",style: const  TextStyle(
                                  fontSize: 80,
                                ),),
                                const Text("C",style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.all(26),
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child:  Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(WeatherIcons.day_windy),
                                    SizedBox(
                                      width:15 ,
                                    ),
                                    Text("Air Speed",style: TextStyle(

                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),)
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text("$air",style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            const Text("km/hr"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding:const  EdgeInsets.all(26),
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child:  Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(WeatherIcons.humidity,size: 24,),
                                    SizedBox(
                                      width:7 ,
                                    ),
                                    Text("Humidity",style: TextStyle(

                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15
                                    ),)
                                  ],
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text("$hum",style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),),
                            const Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child:const  Column(
                    children: [
                      Text("Made By Prateek"),
                      Text("Data Provided By OpenWeathermap.org")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//info?["main_value"] ?? "No data"
