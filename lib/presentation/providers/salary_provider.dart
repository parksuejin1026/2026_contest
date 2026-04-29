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
  final String? errorMessage;

  SalaryDiagnosisState({
    this.isLoading = false,
    this.percentile,
    this.errorMessage,
  });

  SalaryDiagnosisState copyWith({
    bool? isLoading,
    double? percentile,
    String? errorMessage,
  }) {
    return SalaryDiagnosisState(
      isLoading: isLoading ?? this.isLoading,
      percentile: percentile ?? this.percentile,
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
      state = state.copyWith(isLoading: false, percentile: percentile);
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
