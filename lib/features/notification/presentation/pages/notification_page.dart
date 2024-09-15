import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Notification',
              style: semiboldTS.copyWith(fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
