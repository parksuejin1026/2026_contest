import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:math';

class SalaryRepository {
  List<List<dynamic>>? _cachedData;

  /// Loads a CSV file from the assets and parses it into a List of Lists.
  Future<List<List<dynamic>>> loadCsvData() async {
    if (_cachedData != null) return _cachedData!;
    try {
      final rawData = await rootBundle.loadString('assets/data/data_11.csv');
      _cachedData = const CsvToListConverter().convert(rawData);
      return _cachedData!;
    } catch (e) {
      throw Exception('Failed to load CSV data: $e');
    }
  }

  double _calculateZScorePercentile(double value, double mean, double stdDev) {
    double z = (value - mean) / stdDev;
    double t = 1 / (1 + 0.2316419 * z.abs());
    double d = 0.3989423 * exp(-z * z / 2);
    double p = d * t * (0.3193815 + t * (-0.3565638 + t * (1.781478 + t * (-1.821256 + t * 1.330274))));
    if (z > 0) {
      p = 1 - p;
    }
    return p * 100;
  }

  Future<double> calculatePercentile({
    required String industry,
    required String occupation,
    required int experienceYears,
    required double currentSalary,
  }) async {
    final data = await loadCsvData();
    
    double meanSalaryMonthly = 3500; // fallback in thousand KRW
    
    String expBucket = "전경력";
    if (experienceYears < 1) expBucket = "1년미만";
    else if (experienceYears < 3) expBucket = "1~3년미만";
    else if (experienceYears < 5) expBucket = "3~5년미만";
    else if (experienceYears < 10) expBucket = "5~10년미만";
    else expBucket = "10년이상";

    for (var i = 3; i < data.length; i++) {
      if (data[i].length < 5) continue;
      if (data[i][0].toString() == "전직종" && data[i][1].toString() == "전체" && data[i][2].toString() == expBucket) {
        meanSalaryMonthly = double.tryParse(data[i][3].toString()) ?? meanSalaryMonthly;
        break;
      }
    }

    // Convert currentSalary (만원/year) to monthly (천원/month)
    // 5000 만원 = 50,000,000 원. Monthly = 4,166,666 원 = 4166 천원.
    double currentMonthlyK = currentSalary * 10 / 12;
    double stdDev = meanSalaryMonthly * 0.3;
    
    // Normal distribution percentile
    double percentile = _calculateZScorePercentile(currentMonthlyK, meanSalaryMonthly, stdDev);
    
    return percentile.clamp(1.0, 99.0);
  }

  Future<List<double>> getExperienceGrowthCurve() async {
    final data = await loadCsvData();
    List<double> curve = [3000, 3500, 4000, 5000, 6000]; // defaults
    
    try {
      double y1 = 0, y3 = 0, y5 = 0, y10 = 0, y10plus = 0;
      for (var i = 3; i < data.length; i++) {
        if (data[i].length < 5) continue;
        if (data[i][0].toString() == "전직종" && data[i][1].toString() == "전체") {
          String bucket = data[i][2].toString();
          double val = double.tryParse(data[i][3].toString()) ?? 0;
          if (bucket == "1년미만") y1 = val;
          if (bucket == "1~3년미만") y3 = val;
          if (bucket == "3~5년미만") y5 = val;
          if (bucket == "5~10년미만") y10 = val;
          if (bucket == "10년이상") y10plus = val;
        }
      }
      if (y1 > 0) {
        // Convert from monthly 천원 to annual 만원
        curve = [
          (y1 * 12 / 10),
          (y3 * 12 / 10),
          (y5 * 12 / 10),
          (y10 * 12 / 10),
          (y10plus * 12 / 10)
        ];
      }
    } catch (e) {
      // Ignore and use defaults
    }
    return curve;
  }
}
