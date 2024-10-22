import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:flutter/material.dart';

final List<ChatItem> chatItems = [
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Savannah Nguyen',
    message: 'Thank you for your help with the recent project!',
    time: '09:00',
    isOnline: false,
    rank: 'Gold',
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Robert Fox',
    message: 'I just sent you an email. Please check it when you have time.',
    time: '09:20',
    isOnline: false,
    rank: null,
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Guy Hawkins',
    message: 'Remember to bring the documents for tomorrow\'s meeting.',
    time: '09:30',
    isOnline: false,
    rank: 'Silver',
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Leslie Alexander',
    message: 'Have you seen the new movie? It\'s amazing!',
    time: '10:05',
    isOnline: false,
    rank: null,
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Jenny Wilson',
    message: 'Let\'s go for a picnic this weekend!',
    time: '12:15',
    isOnline: true,
    rank: 'Bronze',
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Cameron Williamson',
    message: 'I just finished the new project. Would you like to take a look?',
    time: '14:30',
    isOnline: false,
    rank: 'Silver',
  ),
  const ChatItem(
    avatar: 'assets/images/avt.png',
    name: 'Annette Black',
    message: 'She took a deep breath and prepared to jump off the high dive',
    time: '15:54',
    isOnline: false,
    rank: 'Bronze',
  ),
];

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
        Text(
          time,
          style: TextStyle(color: Colors.grey[600], fontSize: 10),
        ),
      ],
    );
  }
}
