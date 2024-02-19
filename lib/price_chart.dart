import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatelessWidget {
  final List<int> prices;
  // add prices to constructor
  const PriceChart({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: prices
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                .toList(),
          ),
        ],
        clipData: const FlClipData.all(),
      ),
    );
  }
}
