import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/salary_repository.dart';

// Provides a singleton instance of the repository
final salaryRepositoryProvider = Provider<SalaryRepository>((ref) {
  return SalaryRepository();
});

// A state class for holding the form data and results
class SalaryDiagnosisState {
  final bool isLoading;
  final double? percentile;
  final List<double>? growthCurve;
  final double? leverageScore;
  final String? errorMessage;

  SalaryDiagnosisState({
    this.isLoading = false,
    this.percentile,
    this.growthCurve,
    this.leverageScore,
    this.errorMessage,
  });

  SalaryDiagnosisState copyWith({
    bool? isLoading,
    double? percentile,
    List<double>? growthCurve,
    double? leverageScore,
    String? errorMessage,
  }) {
    return SalaryDiagnosisState(
      isLoading: isLoading ?? this.isLoading,
      percentile: percentile ?? this.percentile,
      growthCurve: growthCurve ?? this.growthCurve,
      leverageScore: leverageScore ?? this.leverageScore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// StateNotifier to manage the diagnosis state
class SalaryDiagnosisNotifier extends StateNotifier<SalaryDiagnosisState> {
  final SalaryRepository _repository;

  SalaryDiagnosisNotifier(this._repository) : super(SalaryDiagnosisState());

  Future<void> diagnoseSalary({
    required String industry,
    required String occupation,
    required int experienceYears,
    required double currentSalary,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final percentile = await _repository.calculatePercentile(
        industry: industry,
        occupation: occupation,
        experienceYears: experienceYears,
        currentSalary: currentSalary,
      );
      
      final curve = await _repository.getExperienceGrowthCurve();
      
      // Calculate Leverage Score (e.g. higher percentile = higher leverage)
      // Base score is just the percentile. We add a little bump for experience.
      double leverage = percentile + (experienceYears * 0.5);
      leverage = leverage.clamp(1.0, 100.0);

      state = state.copyWith(
        isLoading: false,
        percentile: percentile,
        growthCurve: curve,
        leverageScore: leverage,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void reset() {
    state = SalaryDiagnosisState();
  }
}

// The provider to expose the state notifier to the UI
final salaryDiagnosisProvider = StateNotifierProvider<SalaryDiagnosisNotifier, SalaryDiagnosisState>((ref) {
  final repository = ref.watch(salaryRepositoryProvider);
  return SalaryDiagnosisNotifier(repository);
});
