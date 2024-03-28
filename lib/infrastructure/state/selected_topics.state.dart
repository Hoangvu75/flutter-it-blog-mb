import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/topic.dart';

part 'selected_topics.state.g.dart';

@Riverpod(keepAlive: true)
class SelectedTopicsState extends _$SelectedTopicsState {
  @override
  List<Topic> build() {
    return [];
  }

  void addTopic(Topic topic) {
    state = [...state, topic];
  }

  void addTopics(List<Topic> topics) {
    state = [...state, ...topics];
  }

  void removeTopic(Topic topic) {
    state = state.where((element) => element.id != topic.id).toList();
  }
}