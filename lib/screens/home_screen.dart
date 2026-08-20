import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widegts/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  Weather? _weatherModel;

  // Get weather data
  Future<void> _getWeather() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a city name')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final weather = await _weatherServices.fetchWeather(
        _controller.text.trim(),
      );

      setState(() {
        _weatherModel = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  // Get background gradient according to weather
  LinearGradient _getBackgroundGradient() {
    final description = _weatherModel?.description.toLowerCase() ?? '';

    // Rain
    if (description.contains('rain')) {
      return const LinearGradient(
        colors: [Color(0xFF348CEC), Color(0xFF0C54BC)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Clear / Sunny
    if (description.contains('clear') || description.contains('sunny')) {
      return const LinearGradient(
        colors: [Color(0xFF1D71F2), Color(0xFF19C3FB)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Cloudy
    if (description.contains('cloud')) {
      return const LinearGradient(
        colors: [Color(0xFF616161), Color(0xFF9BC5C3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Snow
    if (description.contains('snow')) {
      return const LinearGradient(
        colors: [Color(0xFF83A4D4), Color(0xFFB6FBFF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Thunderstorm
    if (description.contains('thunder')) {
      return const LinearGradient(
        colors: [Color(0xFF232526), Color(0xFF414345)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    // Default
    return const LinearGradient(
      colors: [Color(0xFF141E30), Color(0xFF1E3C72)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: _getBackgroundGradient()),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 25),

                  // App Title
                  const Text(
                    'Weather App',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Search Field
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _getWeather(),
                    decoration: InputDecoration(
                      hintText: 'Enter Your City Name',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Get Weather Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _getWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.white54,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Get Weather',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Loading Indicator
                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),

                  // Weather Card
                  if (_weatherModel != null && !_isLoading)
                    WeatherCard(weather: _weatherModel!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
