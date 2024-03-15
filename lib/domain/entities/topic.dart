import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';
part 'topic.g.dart';

@freezed
class Topic with _$Topic {
  factory Topic({
    String? id,
    String? title,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) =>
      _$TopicFromJson(json);
}