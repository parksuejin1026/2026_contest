import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../providers/salary_provider.dart';

class AnalyticsDashboardView extends ConsumerWidget {
  const AnalyticsDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salaryDiagnosisProvider);
    final curve = state.growthCurve ?? [3000, 3500, 4000, 5000, 6000];
    final leverage = state.leverageScore ?? 50.0;

    // Calculate dynamic growth rate
    final double initialS = curve.isNotEmpty ? curve.first : 3000;
    final double finalS = curve.isNotEmpty ? curve.last : 6000;
    final double growthRate = initialS > 0 ? ((finalS - initialS) / initialS) * 100 : 0;

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
                    '직무별 평균 연봉 트렌드 (1년~10년차+)',
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
                                    String text = '';
                                    if (value == 1) text = '1년미만';
                                    else if (value == 3) text = '1~3년';
                                    else if (value == 5) text = '3~5년';
                                    else if (value == 7) text = '5~10년';
                                    else if (value == 10) text = '10년+';
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 12)),
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
                                spots: [
                                  FlSpot(1, curve.length > 0 ? curve[0] : 3000),
                                  FlSpot(3, curve.length > 1 ? curve[1] : 3500),
                                  FlSpot(5, curve.length > 2 ? curve[2] : 4000),
                                  FlSpot(7, curve.length > 3 ? curve[3] : 5000),
                                  FlSpot(10, curve.length > 4 ? curve[4] : 6000),
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
                                Text('10년 누적 상승률', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: growthRate),
                                  duration: const Duration(milliseconds: 2000),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return Text('+${value.toStringAsFixed(1)}%', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.neonGreen));
                                  },
                                ),
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
                                const Icon(Icons.psychology, color: AppTheme.neonPink, size: 48),
                                const SizedBox(height: 16),
                                Text('연봉 협상력 점수', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70)),
                                const SizedBox(height: 8),
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: leverage),
                                  duration: const Duration(milliseconds: 2000),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return Text('${value.toStringAsFixed(1)}점', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppTheme.neonPink));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // New Utilities Section (House Timer & Wealth Simulator)
                  Text(
                    '초개인화 유틸리티',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.deepNavy, AppTheme.deepNavy.withOpacity(0.5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.neonCyan.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.home_work, color: AppTheme.neonCyan, size: 24),
                                  SizedBox(width: 8),
                                  Text('내 집 마련 타이머', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text('서울 아파트(평균)', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text('약 15.2', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.neonCyan)),
                                  const Text(' 년', style: TextStyle(color: Colors.white70)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('*숨만 쉬고 모았을 때 기준', style: TextStyle(color: Colors.white30, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.deepNavy, AppTheme.deepNavy.withOpacity(0.5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.neonPink.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.savings, color: AppTheme.neonPink, size: 24),
                                  SizedBox(width: 8),
                                  Text('10년 뒤 자산 시뮬레이터', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text('연 5% 복리 투자 시', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text('6.2', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppTheme.neonPink)),
                                  const Text(' 억 원', style: TextStyle(color: Colors.white70)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('*월급 50% 저축 가정', style: TextStyle(color: Colors.white30, fontSize: 10)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
