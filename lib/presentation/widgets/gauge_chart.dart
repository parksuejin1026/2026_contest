import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GaugeChart extends StatelessWidget {
  final double percentile;
  final Color activeColor;
  final Color inactiveColor;

  const GaugeChart({
    super.key,
    required this.percentile,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              startDegreeOffset: 180,
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              sections: [
                PieChartSectionData(
                  value: 100 - percentile, // The top percentage
                  color: activeColor,
                  radius: 30,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: percentile, // The remaining percentage
                  color: inactiveColor,
                  radius: 30,
                  showTitle: false,
                ),
                // Transparent bottom half
                PieChartSectionData(
                  value: 100,
                  color: Colors.transparent,
                  radius: 30,
                  showTitle: false,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '상위',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  '${percentile.toInt()}%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: activeColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
