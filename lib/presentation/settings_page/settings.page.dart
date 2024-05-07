import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/config/get_it.dart';
import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../core/util/time.util.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/profile.repository.dart';
import '../../infrastructure/state/my_profile.state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final profileRepository = getIt.get<ProfileRepository>();
  final followingProfiles = <Profile>[].rx;
  final followerProfiles = <Profile>[].rx;

  @override
  void didChangeDependencies() {
    fetchFollowingProfiles();
    fetchFollowerProfiles();
    super.didChangeDependencies();
  }

  Future<void> fetchFollowingProfiles() async {
    final response = await profileRepository.getFollowingProfiles(
      page: 0,
      size: 100,
      profileId: context.provider.read(myProfileStateProvider)?.id ?? '',
    );
    if (response.success == true && response.data != null) {
      followingProfiles.sink.add(response.data!);
    }
  }

  Future<void> fetchFollowerProfiles() async {
    final response = await profileRepository.getFollowerProfiles(
      page: 0,
      size: 100,
      profileId: context.provider.read(myProfileStateProvider)?.id ?? '',
    );
    if (response.success == true && response.data != null) {
      followerProfiles.sink.add(response.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32, width: double.infinity),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                context.provider.read(myProfileStateProvider)?.avatarUrl ??
                    Constants.DEFAULT_AVATAR,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${context.provider.read(myProfileStateProvider)?.firstName} ${context.provider.read(myProfileStateProvider)?.lastName}',
            style: textTitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Joined at ${TimeUtil.getFormattedTime(
              milliseconds:
                  context.provider.read(myProfileStateProvider)?.createdAt ??
                      '',
              format: "yyyy-MM-dd",
            )}',
            style: textBody.copyWith(
              color: colorGreyText,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
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
                          style:
                              textTitle.copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                ],
              ),
              Container(
                width: 1,
                height: 60,
                color: colorLightGrey,
              ),
              Column(
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
                      }),
                ],
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
          )
        ],
      ),
    );
  }
}
