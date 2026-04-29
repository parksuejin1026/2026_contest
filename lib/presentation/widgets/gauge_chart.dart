import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GaugeChart extends StatelessWidget {
  final double percentile; // represents percentile (e.g. 80 means top 20%)
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
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: percentile),
        duration: const Duration(milliseconds: 2500),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  startDegreeOffset: 180,
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  sections: [
                    PieChartSectionData(
                      value: value, // Active part (left to right)
                      color: activeColor,
                      radius: 30,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 100 - value, // Remaining part
                      color: inactiveColor,
                      radius: 30,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 100, // Invisible bottom half
                      color: Colors.transparent,
                      radius: 30,
                      showTitle: false,
                    ),
                  ],
                ),
                swapAnimationDuration: Duration.zero, // Disable default fl_chart animation to let Tween handle it
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
                      '${(100 - value).toInt()}%', // 80th percentile = 상위 20%
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: activeColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
