import 'package:flutter/material.dart';
import '../../core/theme.dart';

class CommunityFeedView extends StatelessWidget {
  const CommunityFeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('직장인 소셜 라운지', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hot Job Ranking
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.local_fire_department, color: Colors.redAccent),
                          SizedBox(width: 8),
                          Text('HOT 요즘 뜨는 직무 연봉 랭킹', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildRankingRow(1, 'AI 프롬프트 엔지니어', '평균 6,200만 원', true),
                      const Divider(),
                      _buildRankingRow(2, '데이터 사이언티스트', '평균 5,800만 원', true),
                      const Divider(),
                      _buildRankingRow(3, '프로덕트 오너 (PO)', '평균 5,500만 원', false),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Blind-style Feed
                const Text('실시간 익명 라운지', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildFeedCard(
                  '골드 직장인', 
                  '3년차 백엔드인데 4천 초반이면 이직해야 하나요?', 
                  '요즘 물가도 미쳤고 다들 5천은 받는 것 같아서 현타옵니다. 이력서 쓰러 갑니다...', 
                  12, 4
                ),
                _buildFeedCard(
                  '다이아몬드 직장인', 
                  '연봉 20% 올려서 이직 성공했습니다 ㅠㅠ', 
                  '진짜 여기 앱에서 시키는 대로 협상력 점수 어필했더니 먹혔어요!! 다들 파이팅!', 
                  45, 18
                ),
                _buildFeedCard(
                  '브론즈 직장인', 
                  '우리 회사 짠돌이인가요? 투표 좀', 
                  '중소기업 5년찬데 3500 실화입니까? 저보다 낮은 분 있나요?', 
                  5, 22
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRankingRow(int rank, String title, String salary, bool isUp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$rank', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue)),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Text(salary, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Icon(isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: isUp ? Colors.red : Colors.blue),
        ],
      ),
    );
  }

  Widget _buildFeedCard(String author, String title, String content, int likes, int comments) {
    Color badgeColor = Colors.grey;
    if (author.contains('다이아몬드')) badgeColor = Colors.cyan.shade700;
    if (author.contains('골드')) badgeColor = Colors.amber.shade700;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.military_tech, color: badgeColor, size: 20),
              const SizedBox(width: 4),
              Text(author, style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold, fontSize: 12)),
              const Spacer(),
              const Text('10분 전', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(content, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text('$likes', style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text('$comments', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ],
      ),
    );
  }
}
