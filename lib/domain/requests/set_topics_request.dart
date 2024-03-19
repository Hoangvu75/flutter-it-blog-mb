class SetTopicsRequest {
  final List<String> topicIds;

  SetTopicsRequest({
    required this.topicIds,
  });

  Map<String, dynamic> toMap() {
    return {
      "topicIds": topicIds,
    };
  }
}
