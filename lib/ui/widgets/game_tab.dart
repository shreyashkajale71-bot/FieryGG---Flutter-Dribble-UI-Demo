import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:flutter/material.dart';

class GameTab extends StatelessWidget {
  const GameTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.container,
            ),
            height: 200,
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Nội dung game sẽ được cập nhật sau',
                style: TextStyle(
                  color: AppColors.active,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
