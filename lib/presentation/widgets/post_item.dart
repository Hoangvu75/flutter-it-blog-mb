import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../core/util/time.util.dart';
import '../../domain/entities/post.dart';
import '../../infrastructure/routing/app_pages.dart';
import '../../infrastructure/state/current_reading_post.state.dart';
import '../../infrastructure/state/favorite_posts.state.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.provider
            .read(currentReadingPostProvider.notifier)
            .setPost(post);
        context.push(Routes.READ_POST);
      },
      child: Container(
        color: colorTransparent,
        child: Column(
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
                          post.author?.avatarUrl ?? Constants.DEFAULT_AVATAR,
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
                      Consumer(builder: (context, ref, child) {
                        final isBookmarked = ref.watch(
                          favoritePostsStateProvider.select(
                            (posts) {
                              for (var favoritePost in posts) {
                                if (favoritePost.id == post.id) {
                                  return true;
                                }
                              }
                              return false;
                            },
                          ),
                        );
                        return IconButton(
                          onPressed: () {
                            if (isBookmarked) {
                              context.provider
                                  .read(favoritePostsStateProvider.notifier)
                                  .removePost(post);
                              return;
                            }
                            context.provider
                                .read(favoritePostsStateProvider.notifier)
                                .addPost(post);
                          },
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: 20,
                            color: isBookmarked ? colorPrimary : colorGreyText,
                          ),
                        );
                      }),
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
        ),
      ),
    );
  }
}
