import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../providers/salary_provider.dart';
import '../widgets/gauge_chart.dart';
import '../widgets/glass_card.dart';

class DiagnosticView extends ConsumerWidget {
  const DiagnosticView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salaryDiagnosisProvider);

    if (state.isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(color: AppTheme.primaryBlue),
              SizedBox(height: 24),
              Text('340만 건의 공공데이터를 비교 분석 중입니다...', style: TextStyle(color: AppTheme.primaryBlue, fontSize: 16)),
            ],
          ),
        ),
      );
    }

    final percentile = state.percentile ?? 50.0;
    
    // Tier Badge logic
    String tier = '브론즈';
    Color tierColor = Colors.brown.shade600;
    if (percentile > 90) {
      tier = '다이아몬드';
      tierColor = Colors.cyan.shade700;
    } else if (percentile > 70) {
      tier = '플래티넘';
      tierColor = Colors.teal.shade700;
    } else if (percentile > 50) {
      tier = '골드';
      tierColor = Colors.amber.shade700;
    } else if (percentile > 30) {
      tier = '실버';
      tierColor = Colors.grey.shade600;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('나의 연봉 리포트', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Hide back button as it's in a tab
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gamification: Tier Badge
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: tierColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: tierColor.withOpacity(0.5), width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.military_tech, color: tierColor, size: 28),
                        const SizedBox(width: 8),
                        Text('$tier 직장인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: tierColor)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                GlassCard(
                  child: Column(
                    children: [
                      Text('대한민국 직장인 중 나의 위치는?', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryBlue)),
                      const SizedBox(height: 32),
                      GaugeChart(
                        percentile: percentile,
                        activeColor: AppTheme.primaryBlue,
                        inactiveColor: AppTheme.softBlue,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Real value converter (Mock data for visualization impact)
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        child: Column(
                          children: [
                            const Text('내 시간의 가치', style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 8),
                            const Text('시급 2.6만원', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                            const SizedBox(height: 8),
                            Text('분급 433원', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassCard(
                        child: Column(
                          children: [
                            const Text('1년 치를 모으면?', style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 8),
                            const Text('소나타 1.5대', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                            const SizedBox(height: 8),
                            Text('또는 오마카세 500번', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
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
    );
  }
}
