import 'package:flutter/material.dart';

class ListFiveDaysWeather extends StatelessWidget {
  const ListFiveDaysWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildDailyTileInfo(
            20,
            33,
            "24-11",
            "Sunny",
            "small clouds",
          );
        },
      ),
    );
  }

  Widget _buildDailyTileInfo(
    final double tempMin,
    final double tempMax,
    final String dateTime,
    final String status,
    final String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Date: $dateTime Temp max: $tempMax/$tempMin°C',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              '$status/$description',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
