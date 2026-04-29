# SalaryLevel App

## Overview
SalaryLevel is an AI-based application designed to diagnose individual salary positions and provide negotiation strategies by merging public data and real-time job market information.

## Features
- **Personalized Salary Diagnosis**: Users can input their industry, job title, experience, location, education, and current salary to receive a salary percentile ranking.
- **Data Fusion Engine**: Combines static data from government sources with dynamic data from job postings to provide accurate salary insights.
- **Negotiation Leverage Report**: Generates reports that offer insights and statistics to aid users in salary negotiations.

## Project Structure
```
salary_level_app
├── android
├── ios
├── lib
│   ├── main.dart
│   ├── app.dart
│   └── src
│       ├── models
│       │   ├── user_profile.dart
│       │   └── salary_stats.dart
│       ├── services
│       │   ├── csv_loader.dart
│       │   ├── worknet_service.dart
│       │   └── data_engine.dart
│       ├── repositories
│       │   └── salary_repository.dart
│       ├── providers
│       │   └── providers.dart
│       ├── ui
│       │   ├── screens
│       │   │   ├── home_screen.dart
│       │   │   └── report_screen.dart
│       │   └── widgets
│       │       └── gauge_chart.dart
│       └── utils
│           └── csv_parser.dart
├── assets
│   └── fonts
├── data
│   ├── csv
│   │   ├── industry_education_age_gender.csv
│   │   ├── job_experience_trend.csv
│   │   └── region_weights.csv
│   └── raw
│       └── public_datasets
├── scripts
│   └── preprocess
│       └── preprocess_csv.py
├── test
│   └── widgets
│       └── widget_test.dart
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
```

## Getting Started
1. **Clone the Repository**: 
   ```
   git clone <repository-url>
   cd salary_level_app
   ```

2. **Install Dependencies**: 
   ```
   flutter pub get
   ```

3. **Run the App**: 
   ```
   flutter run
   ```

## Technologies Used
- **Flutter**: For building the cross-platform mobile application.
- **Dart**: The programming language used for Flutter development.
- **Firebase**: For backend services (initially).
- **Python**: For preprocessing CSV data.

## Future Enhancements
- Integration of more dynamic data sources.
- Advanced analytics features for salary predictions.
- User account management and personalized dashboards.

## License
This project is licensed under the MIT License - see the LICENSE file for details.