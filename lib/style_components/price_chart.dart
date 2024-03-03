import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatelessWidget {
  final List<int> prices;

  const PriceChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
      return LineChart(
          LineChartData(
              gridData: const FlGridData(show: false),
              lineBarsData: [
                  LineChartBarData(
                      spots: prices
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.deepPurple,
                      preventCurveOverShooting: true,
                  )
              ],

              titlesData: const FlTitlesData(

                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)
                  )

              )
          )
      );
    }
}
