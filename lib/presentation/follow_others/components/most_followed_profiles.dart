import 'package:flutter/material.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/rx.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/repository/profile.repository.dart';
import 'profile_item.dart';

class MostFollowedProfiles extends StatefulWidget {
  const MostFollowedProfiles({super.key});

  @override
  State<MostFollowedProfiles> createState() => _MostFollowedProfilesState();
}

class _MostFollowedProfilesState extends State<MostFollowedProfiles> {
  final mostFollowedProfiles = <MostFollowedProfile>[].rx;
  final ProfileRepository profileRepository = getIt.get<ProfileRepository>();

  @override
  void initState() {
    fetchProfiles();
    super.initState();
  }

  Future<void> fetchProfiles() async {
    final response = await profileRepository.getMostFollowedProfiles(
      page: 0,
      size: 10,
    );
    if (response.success == true && response.data != null) {
      mostFollowedProfiles.sink.add(response.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MostFollowedProfile>>(
      stream: mostFollowedProfiles.stream,
      builder: (context, snapshot) => mostFollowedProfiles.value.isEmpty
          ? SizedBox(
              height: screenHeight(context) * 0.5,
              child: const Center(
                child: CircularProgressIndicator(color: colorPrimary),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mostFollowedProfiles.value.length,
              itemBuilder: (context, index) => ProfileItem(
                profile: mostFollowedProfiles.value[index].profile!,
                followerCount: mostFollowedProfiles.value[index].followerCount!,
              ),
            ),
    );
  }
}
