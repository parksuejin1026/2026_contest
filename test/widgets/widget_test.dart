import 'package:flutter_test/flutter_test.dart';
import 'package:salary_level_app/src/ui/widgets/gauge_chart.dart';

void main() {
  testWidgets('GaugeChart displays correct percentile', (WidgetTester tester) async {
    // Arrange
    const double testPercentile = 75.0;

    // Act
    await tester.pumpWidget(GaugeChart(percentile: testPercentile));

    // Assert
    expect(find.text('75%'), findsOneWidget);
    expect(find.byType(GaugeChart), findsOneWidget);
  });

  testWidgets('GaugeChart shows correct visual representation', (WidgetTester tester) async {
    // Arrange
    const double testPercentile = 50.0;

    // Act
    await tester.pumpWidget(GaugeChart(percentile: testPercentile));

    // Assert
    // Here you can add more assertions to check the visual representation
    // For example, checking if the gauge is filled to the correct level
  });
}