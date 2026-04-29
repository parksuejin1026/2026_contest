import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'diagnostic_view.dart';
import 'analytics_dashboard_view.dart';
import 'community_feed_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const DiagnosticView(),
    const AnalyticsDashboardView(),
    const CommunityFeedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppTheme.primaryBlue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.speed), label: '진단 리포트'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: '대시보드'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '라운지'),
        ],
      ),
    );
  }
}
