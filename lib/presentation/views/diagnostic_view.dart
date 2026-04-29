import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../providers/salary_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/gauge_chart.dart';
import 'analytics_dashboard_view.dart';

class DiagnosticView extends ConsumerStatefulWidget {
  const DiagnosticView({super.key});

  @override
  ConsumerState<DiagnosticView> createState() => _DiagnosticViewState();
}

class _DiagnosticViewState extends ConsumerState<DiagnosticView> {
  final _salaryController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _salaryController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _onDiagnosePressed() {
    FocusScope.of(context).unfocus();
    final salary = double.tryParse(_salaryController.text) ?? 0.0;
    final exp = int.tryParse(_experienceController.text) ?? 0;

    ref.read(salaryDiagnosisProvider.notifier).diagnoseSalary(
      industry: 'IT',
      occupation: 'Developer',
      experienceYears: exp,
      currentSalary: salary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final diagnosisState = ref.watch(salaryDiagnosisProvider);

    return Scaffold(
      backgroundColor: AppTheme.softBlue,
      appBar: AppBar(
        title: const Text('연봉 진단', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '당신의 연봉 위치는?',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  if (diagnosisState.percentile != null) ...[
                    GaugeChart(
                      percentile: diagnosisState.percentile!,
                      activeColor: AppTheme.primaryBlue,
                      inactiveColor: Colors.white,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnalyticsDashboardView(),
                          ),
                        );
                      },
                      child: const Text('상세 분석 대시보드 보기'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Reset diagnosis
                        ref.read(salaryDiagnosisProvider.notifier).reset();
                      },
                      child: const Text('다시 진단하기', style: TextStyle(fontSize: 16)),
                    )
                  ] else ...[
                    TextField(
                      controller: _salaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '현재 연봉 (만원)',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.monetization_on, color: AppTheme.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _experienceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '경력 (년차)',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.work_history, color: AppTheme.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: diagnosisState.isLoading ? null : _onDiagnosePressed,
                      child: diagnosisState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('진단하기'),
                    ),
                  ],
                  if (diagnosisState.errorMessage != null) ...[
                    const SizedBox(height: 24),
                    Text(
                      '오류: ${diagnosisState.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
