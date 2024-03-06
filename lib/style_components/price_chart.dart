import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatelessWidget {
  final List<int> prices;

  const PriceChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      maxX: prices.length.toDouble(),
      maxY: prices
              .reduce((value, element) => value > element ? value : element)
              .toDouble() +
          prices
                  .reduce((value, element) => value > element ? value : element)
                  .toDouble() *
              0.05,
      minX: 0,
      minY: prices
              .reduce((value, element) => value < element ? value : element)
              .toDouble() -
          prices
                  .reduce((value, element) => value < element ? value : element)
                  .toDouble() *
              0.05,
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
          preventCurveOvershootingThreshold: 0.5,
        ),
      ],
      titlesData: const FlTitlesData(
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            // average price
            y: prices.fold(0, (p, c) => p + c) /
                prices.length, // average price of all products in the list
            color: Colors.green,
            strokeWidth: 2,
            dashArray: [10, 5], // dash length and space length
          ),
        ],
      ),
    ));
  }
}
