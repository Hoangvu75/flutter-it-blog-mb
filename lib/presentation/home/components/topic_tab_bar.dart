import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../infrastructure/state/current_post_topic.state.dart';
import '../../../infrastructure/state/my_profile.state.dart';

class TopicTabBar extends StatefulWidget {
  const TopicTabBar({
    super.key,
  });

  @override
  State<TopicTabBar> createState() => _TopicTabBarState();
}

class _TopicTabBarState extends State<TopicTabBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBackground,
      child: Consumer(builder: (context, ref, child) {
        final myProfile = ref.watch(myProfileStateProvider);
        final favoriteTopics = myProfile?.favoriteTopics;
        final tabController = TabController(
          length: 2 + (favoriteTopics?.length ?? 0),
          vsync: this,
        )..animateTo(1);
        return TabBar(
          controller: tabController,
          indicatorColor: colorPrimary,
          labelColor: colorPrimary,
          unselectedLabelColor: colorLightGrey,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: MaterialStateProperty.all(colorTransparent),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          onTap: (index) {
            if (index == 0 || index == 1) {
              return context.provider
                  .read(currentPostTopicStateProvider.notifier)
                  .setTopicId(null);
            }
            final topic = favoriteTopics![index - 2];
            print(topic.id);
            return context.provider
                .read(currentPostTopicStateProvider.notifier)
                .setTopicId(topic.id);
          },
          tabs: [
            const Icon(
              Icons.add,
              size: 24,
            ),
            const Tab(
              text: "For You",
            ),
            ...List.generate(
              favoriteTopics?.length ?? 0,
              (index) {
                final topic = favoriteTopics![index];
                return Tab(
                  text: topic.title,
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
