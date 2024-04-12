import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repository/post.repository.dart';
import '../../widgets/post_item.dart';

class FavoritePosts extends StatefulWidget {
  const FavoritePosts({super.key});

  @override
  State<FavoritePosts> createState() => _FavoritePostsState();
}

class _FavoritePostsState extends State<FavoritePosts> {
  final posts = BehaviorSubject<List<Post>?>.seeded(null);
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
    posts.add([...?posts.value, ...loadMorePosts.data ?? []]);
    currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: posts.stream,
      builder: (context, snapshot) => posts.value == null
          ? SizedBox(
              height: screenHeight(context) * 0.5,
              child: const Center(
                child: CircularProgressIndicator(color: colorPrimary),
              ),
            )
          : Column(
              children: List.generate(
                posts.value!.length,
                (index) => PostItem(post: posts.value![index]),
              )
                ..add(
                  (posts.value!.length > 9)
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
                                  color: colorPrimary),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
            ),
    );
  }
}
