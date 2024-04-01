import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/rx.extension.dart';
import '../../../core/firebase/google_ad_id_manager.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repository/post.repository.dart';
import '../../widgets/post_item.dart';

class PostList extends StatefulWidget {
  final String? topicId;

  const PostList({super.key, this.topicId});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final posts = <Post>[].rx;
  final postRepository = getIt.get<PostRepository>();
  var currentPage = 0;

  @override
  void initState() {
    loadPost();
    super.initState();
  }

  void loadPost() async {
    final loadMorePosts = (widget.topicId != null)
        ? await postRepository.getPostsByTopicId(
            topicId: widget.topicId!,
            page: currentPage,
            size: 10,
          )
        : await postRepository.getPosts(
            page: currentPage,
            size: 10,
          );
    posts.add([...posts.value, ...loadMorePosts.data ?? []]);
    currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: posts.stream,
      builder: (context, snapshot) => posts.value.isEmpty
          ? SizedBox(
              height: screenHeight(context) * 0.5,
              child: const Center(
                child: CircularProgressIndicator(color: colorPrimary),
              ),
            )
          : Column(
              children: List.generate(
                posts.value.length,
                (index) => PostItem(post: posts.value[index]),
              )
                ..insert(
                  2,
                  EasyBannerAd(
                    adId: adIdManager.admobAdIds!.bannerId!,
                    adSize: AdSize(
                      width: screenWidth(context).toInt(),
                      height: 160,
                    ),
                  ),
                )
                ..add(
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: VisibilityDetector(
                      key: const Key("load_more"),
                      onVisibilityChanged: (info) async {
                        if (info.visibleFraction >= 0.5) {
                          loadPost();
                        }
                      },
                      child: const Center(
                        child: CircularProgressIndicator(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
            ),
    );
  }
}
