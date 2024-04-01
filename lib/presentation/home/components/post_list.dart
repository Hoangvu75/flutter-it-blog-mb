import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/rx.extension.dart';
import '../../../core/firebase/google_ad_id_manager.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../core/util/time.util.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repository/post.repository.dart';

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
    posts.add(
      [...posts.value, ...loadMorePosts.data ?? []],
    );
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
                (index) => _PostItem(post: posts.value[index]),
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

class _PostItem extends StatelessWidget {
  final Post post;

  const _PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth(context),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                      post.author?.avatarUrl ?? "",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${post.author?.firstName} ${post.author?.lastName}",
                    style: textBody,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title ?? "",
                          style: textLargeBody.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${TimeUtil.getFormattedTime(
                            milliseconds: post.createdAt!,
                            format: "MMM d",
                          )} • ${TimeUtil.getFormattedTime(
                            milliseconds: post.createdAt!,
                            format: "h:mm a",
                          )}",
                          style: textBody.copyWith(
                            color: colorGreyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.network(
                    post.thumbnailUrl ?? "",
                    width: 80,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorSuperLightGrey,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      post.topics![0].title!,
                      style: textCaption,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.bookmark_add_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 24),
                  const Icon(
                    Icons.share_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 24),
                  const Icon(
                    Icons.more_horiz_outlined,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: colorLightGrey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
