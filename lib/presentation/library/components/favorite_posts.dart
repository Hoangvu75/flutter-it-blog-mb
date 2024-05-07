import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repository/post.repository.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/favorite_posts.state.dart';
import '../../widgets/post_item.dart';

class FavoritePosts extends StatefulWidget {
  const FavoritePosts({super.key});

  @override
  State<FavoritePosts> createState() => _FavoritePostsState();
}

class _FavoritePostsState extends State<FavoritePosts> {
  final postRepository = getIt.get<PostRepository>();
  var currentPage = 0;

  @override
  void initState() {
    loadPost();
    super.initState();
  }

  void loadPost() async {
    final loadMorePosts = await postRepository.getFavoritePosts(
      page: currentPage,
      size: 10,
    );
    navContext?.provider
        .read(favoritePostsStateProvider.notifier)
        .addPosts(loadMorePosts.data ?? []);
    currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final posts = ref.watch(favoritePostsStateProvider);
        return Column(
          children: List.generate(
            posts.length,
                (index) => PostItem(post: posts[index]),
          )..add(
            (posts.length > 9)
                ? Padding(
              padding: const EdgeInsets.all(32),
              child: VisibilityDetector(
                key: const Key("load_more"),
                onVisibilityChanged: (info) async {
                  if (info.visibleFraction >= 0.5) {
                    loadPost();
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    color: colorPrimary,
                  ),
                ),
              ),
            )
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
