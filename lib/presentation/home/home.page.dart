import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';

import '../../core/ui/text.ui.dart';
import '../../infrastructure/routing/app_pages.dart';
import '../../infrastructure/state/current_post_topic.state.dart';
import 'components/post_list.dart';
import 'components/topic_tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 8,
            ),
            child: Row(
              children: [
                Text(
                  "Home",
                  style: textLargeTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () => context.push(Routes.CREATE_POST),
                  icon: const Icon(
                    Icons.create_outlined,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverStickyHeader(
          header: const TopicTabBar(),
          sliver: SliverToBoxAdapter(
            child: Consumer(builder: (context, ref, child) {
              final topicId = ref.watch(currentPostTopicStateProvider);
              if (topicId == null) {
                return const PostList();
              }
              return PostList(
                key: ValueKey(topicId),
                topicId: topicId,
              );
            }),
          ),
        ),
      ],
    );
  }
}
