import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class SalaryRepository {
  /// Loads a CSV file from the assets and parses it into a List of Lists.
  Future<List<List<dynamic>>> loadCsvData(String filePath) async {
    try {
      final rawData = await rootBundle.loadString(filePath);
      List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
      return listData;
    } catch (e) {
      // Return empty list or rethrow depending on error handling strategy
      throw Exception('Failed to load CSV data: $e');
    }
  }

  /// Example function: Fetch mock percentile data
  /// Later, this will merge CSV stats and real-time Worknet API data
  Future<double> calculatePercentile({
    required String industry,
    required String occupation,
    required int experienceYears,
    required double currentSalary,
  }) async {
    // TODO: Implement actual data fusion and calculation logic based on CSV
    // This is a mock response for MVP UI rendering
    await Future.delayed(const Duration(seconds: 1)); // Simulate processing delay
    
    // Fake percentile calculation
    return 65.5; // Top 34.5%
  }
}
