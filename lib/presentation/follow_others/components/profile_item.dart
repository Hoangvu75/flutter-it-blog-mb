import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../core/extensions/rx.extension.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/repository/follow.repository.dart';

class ProfileItem extends StatelessWidget {
  final Profile profile;
  final int followerCount;

  const ProfileItem({
    super.key,
    required this.profile,
    required this.followerCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.titleHeight,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profile.avatarUrl.toString()),
      ),
      title: Text(
        "${profile.firstName!} ${profile.lastName!}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${profile.lastName!} is ${profile.job!} at ${profile.company!}.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Followers: $followerCount",
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
      trailing: Builder(
        builder: (context) {
          final isFollowing = false.rx;
          return StreamBuilder<bool>(
            stream: isFollowing.stream,
            builder: (context, snapshot) => ScaleTap(
              onPressed: () {
                isFollowing.add(!isFollowing.value);
                final followRepository = getIt.get<FollowRepository>();
                if (isFollowing.value) {
                  return followRepository.follow(profile.id!);
                }
                return followRepository.unfollow(profile.id!);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 12,
                  right: 8,
                ),
                decoration: BoxDecoration(
                  color: isFollowing.value ? colorSecondary : colorPrimary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorPrimary,
                  ),
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  clipBehavior: Clip.none,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isFollowing.value ? "Following" : "Follow",
                        style: textCaption.copyWith(
                          color:
                              isFollowing.value ? colorPrimary : colorSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isFollowing.value ? Icons.check : Icons.add,
                        color:
                            isFollowing.value ? colorPrimary : colorSecondary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
