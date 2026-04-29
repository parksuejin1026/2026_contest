import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../providers/salary_provider.dart';
import 'main_tab_view.dart';

class LandingPageView extends ConsumerStatefulWidget {
  const LandingPageView({super.key});

  @override
  ConsumerState<LandingPageView> createState() => _LandingPageViewState();
}

class _LandingPageViewState extends ConsumerState<LandingPageView> {
  double _salary = 4000;
  double _experience = 3;

  void _submit() {
    // 마찰 제로 폼: 타자 칠 필요 없이 슬라이더로만 입력 후 즉시 전송
    ref.read(salaryDiagnosisProvider.notifier).diagnoseSalary(
      industry: 'IT',
      occupation: 'Developer',
      experienceYears: _experience.toInt(),
      currentSalary: _salary,
    );
    
    // 로딩 메시지("340만 건 데이터 분석 중...")를 모방하는 딜레이 추가 후 화면 전환
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MainTabView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: AppTheme.pastelAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.auto_awesome, size: 64, color: AppTheme.primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    '나의 진짜 가치를\n확인할 시간입니다.',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      height: 1.3,
                      color: AppTheme.textLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 64),
                  
                  // 스포트라이트 폼 UI (키보드 없이 입력)
                  Text('현재 연봉: ${_salary.toInt()} 만원', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                  Slider(
                    value: _salary,
                    min: 2000,
                    max: 20000,
                    divisions: 180,
                    activeColor: AppTheme.primaryBlue,
                    inactiveColor: AppTheme.softBlue,
                    onChanged: (val) => setState(() => _salary = val),
                  ),
                  const SizedBox(height: 32),
                  
                  Text('경력: ${_experience.toInt()} 년차', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
                  Slider(
                    value: _experience,
                    min: 0,
                    max: 20,
                    divisions: 20,
                    activeColor: AppTheme.primaryBlue,
                    inactiveColor: AppTheme.softBlue,
                    onChanged: (val) => setState(() => _experience = val),
                  ),
                  
                  const SizedBox(height: 64),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('📊 340만 건 공공데이터와 비교하기', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 16, color: Colors.grey.shade400),
                      const SizedBox(width: 8),
                      Text('입력하신 정보는 서버에 저장되지 않고 즉시 익명 처리됩니다.', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
