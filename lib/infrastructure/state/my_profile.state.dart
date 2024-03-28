import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/extensions/context.extension.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/topic.dart';
import '../routing/app_pages.dart';
import 'selected_topics.state.dart';

part 'my_profile.state.g.dart';

@Riverpod(keepAlive: true)
class MyProfileState extends _$MyProfileState {
  @override
  Profile? build() {
    return null;
  }

  void setProfile(Profile profile) {
    state = profile;
    final myTopics =
        navContext?.provider.read(myProfileStateProvider)?.favoriteTopics ?? [];
    navContext?.provider
        .read(selectedTopicsStateProvider.notifier)
        .addTopics(myTopics);
  }

  void setTopics(List<Topic> topics) {
    state = state?.copyWith(favoriteTopics: topics);
    print('topic set');
    print(state.toString());
  }
}
