import 'package:flutter/material.dart';
import '../../../../core/constant.dart';
import '../widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Home',
                style: semiboldTS.copyWith(fontSize: 28),
              ),
            ),
            // const SizedBox(height: 16),
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
              dividerHeight: 2,
              dividerColor: Theme.of(context).splashColor,
              tabs: const [
                Tab(text: 'Discover'),
                Tab(text: 'Following'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      ...List.generate(
                        5,
                        (index) => const PostCard(
                          name: 'Namaku Bento',
                          time: 'a few seconds ago',
                          post:
                              'Nostrud commodo fugiat adipisicing sit consectetur amet nisi qui. Eu dolore nisi sint minim Lorem cillum voluptate in et qui voluptate. Dolore ullamco incididunt ipsum enim laboris anim aliqua ut velit. Ut elit exercitation pariatur duis esse qui ad do id. Magna irure ex laboris aliquip labore mollit est pariatur excepteur. Culpa sunt velit do eiusmod occaecat cupidatat consequat aliquip.',
                          like: 17,
                          reply: 3,
                        ),
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
