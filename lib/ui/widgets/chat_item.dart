import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final bool isOnline;
  final String? rank;

  const ChatItem({
    super.key,
    required this.avatar,
    required this.name,
    required this.message,
    required this.time,
    required this.isOnline,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.backgroundWidget.withOpacity(0.9),
            border: Border.all(color: AppColors.container, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNameAndTime(),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: const TextStyle(
                          color: AppColors.unactive, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isOnline
                  ? Border.all(
                      color: AppColors.green1,
                      width: 2,
                    )
                  : null,
            ),
            child: ClipOval(
              child: Image.asset('assets/images/avt.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: isOnline ? AppColors.green1 : AppColors.active,
              fontWeight: FontWeight.bold,
              fontSize: 13),
        ),
        const SizedBox(width: 4),
        if (rank != null) ...[
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: _getRankColor().withOpacity(0.9),
                border: Border.all(color: _getRankColor(), width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  rank![0].toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.active,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
        Text(
          time,
          style: TextStyle(color: Colors.grey[600], fontSize: 10),
        ),
      ],
    );
  }

  Color _getRankColor() {
    switch (rank?.toLowerCase()) {
      case 'gold':
        return Colors.amber;
      case 'silver':
        return Colors.blue;
      case 'bronze':
        return Colors.brown;
      default:
        return AppColors.container;
    }
  }
}
