// import 'package:flutter/material.dart';
// import 'package:weather_app/models/weather_model.dart';
// import 'package:weather_app/services/weather_services.dart';
// import 'package:weather_app/widegts/weather_card.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final WeatherServices _weatherServices = WeatherServices();
//   final TextEditingController _controller = TextEditingController();
//   bool _isLoading = false;

//   Weather? _weatherModel;

//   void _getWeather() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final weather = await _weatherServices.fetchWeather(_controller.text);
//       setState(() {
//         _weatherModel = weather;
//         _isLoading = false;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error fetching Weather Data')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient:
//               _weatherModel != null &&
//                   _weatherModel!.description.toLowerCase().contains('rain')
//               ? LinearGradient(
//                   colors: [Color(0XFF348cec), Color(0xff0c54bc)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 )
//               : _weatherModel != null &&
//                     _weatherModel!.description.toLowerCase().contains('clear')
//               ? LinearGradient(
//                   colors: [Color(0XFF1D71F2), Color(0xff19C3FB)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 )
//               : _weatherModel != null &&
//                     _weatherModel!.description.toLowerCase().contains('sunny')
//               ? LinearGradient(
//                   colors: [Color(0XFFE05B19), Color(0xff792CA2)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 )
//               : LinearGradient(
//                   colors: [Color(0XFF141E30), Color(0xff1E3C72)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 SizedBox(height: 25),
//                 Text(
//                   "Weather App",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 TextField(
//                   controller: _controller,
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: "Enter Your city Name",
//                     hintStyle: TextStyle(color: Colors.white70),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.3),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _getWeather,
//                   child: Text("Get Weather", style: TextStyle(fontSize: 18)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(159, 96, 125, 139),
//                     foregroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//                 if (_isLoading)
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ),

//                 if (_weatherModel != null) WeatherCard(weather: _weatherModel!),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
