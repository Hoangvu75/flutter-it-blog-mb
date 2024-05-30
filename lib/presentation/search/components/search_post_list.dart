import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/rx.extension.dart';
import '../../../core/firebase/google_ad_id_manager.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repository/post.repository.dart';
import '../../../infrastructure/state/post_search_key.state.dart';
import '../../widgets/post_item.dart';

class SearchPostList extends StatefulWidget {
  const SearchPostList({super.key});

  @override
  State<SearchPostList> createState() => _SearchPostListState();
}

class _SearchPostListState extends State<SearchPostList> {
  final posts = <Post>[].rx;
  final postRepository = getIt.get<PostRepository>();
  var currentPage = 0;

  Future<void> loadPost(String searchKey) async {
    final searchPosts = await postRepository.searchPost(
      searchKey: searchKey,
      page: currentPage,
      size: 10,
    );
    posts.add([...posts.value, ...searchPosts.data ?? []]);
    currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchKey = ref.watch(postSearchKeyProvider);
        if (searchKey != null) {
          loadPost(searchKey);
        } else {
          posts.add([]);
          currentPage = 0;
        }
        return StreamBuilder(
          stream: posts.stream,
          builder: (context, snapshot) => posts.value.isEmpty
              ? searchKey == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: screenHeight(context) * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(color: colorPrimary),
                      ),
                    )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Search Results for "$searchKey"',
                        style: textTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(
                      posts.value.length,
                      (index) => PostItem(post: posts.value[index]),
                    )
                      ..add(
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: VisibilityDetector(
                            key: const Key("load_more"),
                            onVisibilityChanged: (info) async {
                              if (info.visibleFraction >= 0.5) {
                                loadPost(searchKey!);
                              }
                            },
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: colorPrimary),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
