import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Search',
              style: semiboldTS.copyWith(fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
