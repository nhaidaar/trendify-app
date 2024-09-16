import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendify/features/home/presentation/cubit/home_cubit.dart';
import '../../../../core/constant.dart';
import '../widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocProvider.of<HomeCubit>(context)..fetchAllPosts(),
      child: DefaultTabController(
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
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await context.read<HomeCubit>().fetchAllPosts();
                          },
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            children: [
                              if (state is HomeLoading)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                              else if (state is HomeSuccess && state.posts.isNotEmpty)
                                ...state.posts.map((post) => PostCard(model: post))
                              else
                                Center(
                                  child: Text(
                                    'Nothing here, maybe there\'s an error?',
                                    style: mediumTS,
                                  ),
                                ),
                            ],
                          ),
                        );
                        // if (state is HomeLoading) {
                        //   return const Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        // if (state is HomeSuccess && state.posts.isNotEmpty) {
                        //   return ListView(
                        //     padding: const EdgeInsets.symmetric(vertical: 16),
                        //     children: state.posts.map((post) {
                        //       return PostCard(model: post);
                        //     }).toList(),
                        //   );
                        // }
                        // return Center(
                        //   child: Text(
                        //     'Nothing here, maybe there\'s an error?',
                        //     style: mediumTS,
                        //   ),
                        // );
                      },
                    ),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
