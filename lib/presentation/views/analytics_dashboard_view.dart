import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AnalyticsDashboardView extends StatelessWidget {
  const AnalyticsDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Force the dark theme for this specific screen
    return Theme(
      data: AppTheme.darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analytics Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '직무별 연봉 트렌드',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 350,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24.0, left: 16.0, top: 32.0, bottom: 16.0),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              getDrawingHorizontalLine: (value) => const FlLine(color: Colors.white10, strokeWidth: 1),
                              getDrawingVerticalLine: (value) => const FlLine(color: Colors.white10, strokeWidth: 1),
                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text('${value.toInt()}년차', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 50,
                                  getTitlesWidget: (value, meta) {
                                    return Text('${(value / 1000).toInt()}천', style: const TextStyle(color: Colors.white70, fontSize: 12));
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(1, 3500),
                                  FlSpot(3, 4200),
                                  FlSpot(5, 5800),
                                  FlSpot(7, 7500),
                                  FlSpot(10, 9500),
                                ],
                                isCurved: true,
                                color: AppTheme.neonCyan,
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(show: true, getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(radius: 6, color: AppTheme.neonPink, strokeWidth: 2, strokeColor: AppTheme.deepNavy);
                                }),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: AppTheme.neonCyan.withOpacity(0.15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                const Icon(Icons.trending_up, color: AppTheme.neonGreen, size: 48),
                                const SizedBox(height: 16),
                                Text('평균 상승률', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                                const SizedBox(height: 8),
                                Text('+12.4%', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.neonGreen)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                const Icon(Icons.groups, color: AppTheme.neonPink, size: 48),
                                const SizedBox(height: 16),
                                Text('경쟁자 수', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                                const SizedBox(height: 8),
                                Text('2,451명', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.neonPink)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
