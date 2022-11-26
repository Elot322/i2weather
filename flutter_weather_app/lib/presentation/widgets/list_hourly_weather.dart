import 'package:flutter/material.dart';

class ListHourlyWeather extends StatelessWidget {
  const ListHourlyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _buildHourTileInfo("11:00", 20);
      },
    );
  }

  Widget _buildHourTileInfo(String time, double temp) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(120, 6, 6, 7),
      ),
      child: Center(
        child: Text(
          'Time: $time  Temp: $temp°C',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
