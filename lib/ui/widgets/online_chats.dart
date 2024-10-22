import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:fiery_gg/ui/widgets/chat_item.dart';
import 'package:flutter/material.dart';

class OnlineChats extends StatelessWidget {
  final List<ChatItem> chatItems;

  const OnlineChats({super.key, required this.chatItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(child: _buildChatList()),
        _buildInputField(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 5),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.chat, color: Colors.blue, size: 20),
              const SizedBox(width: 10),
              const Text('Online Chat',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)),
              const Spacer(),
              const Icon(Icons.person, color: AppColors.green1, size: 14),
              const SizedBox(width: 5),
              const Text('1857',
                  style: TextStyle(
                      color: AppColors.active,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWidget.withOpacity(0.9),
                    border: Border.all(color: AppColors.container, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.unactive,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Divider(
              color: AppColors.container,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          return chatItems[index];
        },
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.backgroundWidget.withOpacity(0.9),
          border: Border.all(color: AppColors.container, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write message...',
                  hintStyle: TextStyle(color: AppColors.unactive, fontSize: 12),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWidget.withOpacity(0.9),
                      border: Border.all(color: AppColors.container, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.emoji_emotions,
                        color: AppColors.unactive,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.9),
                      border: Border.all(color: AppColors.primary, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: AppColors.active,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
