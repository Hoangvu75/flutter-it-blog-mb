import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../core/config/get_it.dart';
import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../core/util/time.util.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/follow.repository.dart';
import '../../domain/repository/post.repository.dart';
import '../../domain/repository/profile.repository.dart';
import '../../infrastructure/state/current_other_profile.state.dart';
import '../../infrastructure/state/my_profile.state.dart';
import '../widgets/post_item.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({super.key});

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  final profileRepository = getIt.get<ProfileRepository>();
  final postRepository = getIt.get<PostRepository>();
  final followRepository = getIt.get<FollowRepository>();
  final followingProfiles = <Profile>[].rx;
  final followerProfiles = <Profile>[].rx;
  final myPost = <Post>[].rx;
  final isFollowing = false.rx;

  @override
  void didChangeDependencies() {
    fetchFollowingProfiles();
    fetchFollowerProfiles();
    fetchMyPosts();
    super.didChangeDependencies();
  }

  Future<void> fetchFollowingProfiles() async {
    final response = await profileRepository.getFollowingProfiles(
      page: 0,
      size: 100,
      profileId:
          context.provider.read(currentOtherProfileStateProvider)?.id ?? '',
    );
    if (response.success == true && response.data != null) {
      followingProfiles.sink.add(response.data!);
    }
  }

  Future<void> fetchFollowerProfiles() async {
    final response = await profileRepository.getFollowerProfiles(
      page: 0,
      size: 100,
      profileId:
          context.provider.read(currentOtherProfileStateProvider)?.id ?? '',
    );
    if (response.success == true && response.data != null) {
      followerProfiles.sink.add(response.data!);
    }
    if (response.data != null) {
      isFollowing.value = response.data!.any((element) =>
          element.id == context.provider.read(myProfileStateProvider)!.id);
    }
  }

  Future<void> fetchMyPosts() async {
    final response = await postRepository.getPostsByAuthorId(
      authorId:
          context.provider.read(currentOtherProfileStateProvider)?.id ?? '',
    );
    if (response.success == true && response.data != null) {
      myPost.sink.add(response.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorTransparent,
        title: Text(
          "Profile",
          style: textTitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32, width: double.infinity),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  context.provider
                          .read(currentOtherProfileStateProvider)
                          ?.avatarUrl ??
                      Constants.DEFAULT_AVATAR,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${context.provider.read(currentOtherProfileStateProvider)?.firstName} ${context.provider.read(currentOtherProfileStateProvider)?.lastName}',
              style: textTitle.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Joined at ${TimeUtil.getFormattedTime(
                milliseconds: context.provider
                        .read(currentOtherProfileStateProvider)
                        ?.createdAt ??
                    '',
                format: "yyyy-MM-dd",
              )}',
              style: textBody.copyWith(
                color: colorGreyText,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<bool>(
                stream: isFollowing.stream,
                builder: (context, snapshot) {
                  return AnimatedSwitcher(
                    key: ValueKey(isFollowing.value),
                    duration: const Duration(milliseconds: 300),
                    child: isFollowing.value
                        ? ScaleTap(
                            onPressed: () {
                              isFollowing.value = !isFollowing.value;
                            },
                            child: Container(
                              width: 140,
                              height: 32,
                              decoration: BoxDecoration(
                                color: colorSecondary,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: colorPrimary, width: 1),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Following',
                                      style: textBody.copyWith(
                                        color: colorPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.check,
                                      color: colorPrimary,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : ScaleTap(
                            onPressed: () {
                              isFollowing.value = !isFollowing.value;
                              followRepository.follow(context.provider
                                  .read(currentOtherProfileStateProvider)!
                                  .id!);
                              followerProfiles.sink.add([
                                ...followerProfiles.value,
                                context.provider.read(myProfileStateProvider)!
                              ]);
                            },
                            child: Container(
                              width: 120,
                              height: 32,
                              decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Follow',
                                  style: textBody.copyWith(
                                    color: colorSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  );
                }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                "Following people",
                                style: textTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: followingProfiles.value
                                    .map(
                                      (profile) => ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              profile.avatarUrl ??
                                                  Constants.DEFAULT_AVATAR),
                                        ),
                                        title: Text(
                                          '${profile.firstName} ${profile.lastName}',
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Followings',
                        style: textLargeBody.copyWith(color: colorGreyText),
                      ),
                      const SizedBox(height: 6),
                      StreamBuilder<List<Profile>>(
                          stream: followingProfiles.stream,
                          builder: (context, snapshot) {
                            return Text(
                              '${followingProfiles.value.length}',
                              style: textTitle.copyWith(
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: colorLightGrey,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                "Follower people",
                                style: textTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                children: followerProfiles.value
                                    .map(
                                      (profile) => ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              profile.avatarUrl ??
                                                  Constants.DEFAULT_AVATAR),
                                        ),
                                        title: Text(
                                          '${profile.firstName} ${profile.lastName}',
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        'Followers',
                        style: textLargeBody.copyWith(color: colorGreyText),
                      ),
                      const SizedBox(height: 6),
                      StreamBuilder<List<Profile>>(
                        stream: followerProfiles.stream,
                        builder: (context, snapshot) {
                          return Text(
                            '${followerProfiles.value.length}',
                            style:
                                textTitle.copyWith(fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your public posts',
                  style: textSmallTitle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<Post>>(
              stream: myPost.stream,
              builder: (context, snapshot) {
                return Column(
                  children: myPost.value
                      .map(
                        (post) => PostItem(post: post),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
