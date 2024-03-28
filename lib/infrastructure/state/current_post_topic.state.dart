import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_post_topic.state.g.dart';

@riverpod
class CurrentPostTopicState extends _$CurrentPostTopicState {
  @override
  String? build() {
    return null;
  }

  void setTopicId(String? value) {
    state = value;
  }
}