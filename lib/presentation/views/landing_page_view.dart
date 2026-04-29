import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'diagnostic_view.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  color: AppTheme.pastelAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_graph, size: 80, color: AppTheme.primaryBlue),
              ),
              const SizedBox(height: 56),
              Text(
                '나의 가치를\n데이터로 증명하다',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  height: 1.2,
                  color: AppTheme.textLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                '수백만 건의 실제 연봉 데이터를 기반으로\n당신의 정확한 연봉 위치와 협상력을 진단해드립니다.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DiagnosticView()),
                  );
                },
                child: const Text('무료 연봉 진단 시작하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
