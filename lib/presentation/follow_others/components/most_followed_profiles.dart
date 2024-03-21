import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/repository/profile.repository.dart';

class MostFollowedProfiles extends StatefulWidget {
  const MostFollowedProfiles({super.key});

  @override
  State<MostFollowedProfiles> createState() => _MostFollowedProfilesState();
}

class _MostFollowedProfilesState extends State<MostFollowedProfiles> {
  final ProfileRepository profileRepository = getIt.get<ProfileRepository>();
  final List<MostFollowedProfile> mostFollowedProfiles = [];

  @override
  void initState() {
    profileRepository
        .getMostFollowedProfiles(page: 0, size: 10)
        .then((value) {
      if (value.success == true && value.data != null) {
        setState(() {
          mostFollowedProfiles.addAll(value.data!);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mostFollowedProfiles.length,
      itemBuilder: (context, index) {
        final data = mostFollowedProfiles[index];
        return ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.profile!.avatarUrl. toString()),
          ),
          title: Text(
            "${data.profile!.firstName!} ${data.profile!.lastName!}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.profile!.lastName!} is ${data.profile!.job!} at ${data.profile!.company!}.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Followers: ${data.followerCount}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: ScaleTap(
            onPressed: () {},
            child: Text(
              "Follow",
              style: textBody.copyWith(
                color: colorGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
