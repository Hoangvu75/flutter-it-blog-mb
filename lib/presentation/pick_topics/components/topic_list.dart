import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/entities/topic.dart';
import '../../../domain/repository/topic.repository.dart';
import '../../../infrastructure/state/selected_topics.state.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final List<Topic> topicList = [];
  final topicRepository = getIt.get<TopicRepository>();

  @override
  void initState() {
    topicRepository.getTopics().then((value) {
      if (value.success == true && value.data != null) {
        setState(() {
          topicList.addAll(value.data!);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: topicList
            .map(
              (topic) => ScaleTap(
                onPressed: () {
                  final selectedTopicsState = context.provider
                      .read(selectedTopicsStateProvider.notifier);
                  if (!context.provider
                      .read(selectedTopicsStateProvider)
                      .contains(topic)) {
                    selectedTopicsState.addTopic(topic);
                  } else {
                    selectedTopicsState.removeTopic(topic);
                  }
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final isSelected =
                        ref.watch(selectedTopicsStateProvider).contains(topic);
                    return Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: isSelected ? colorTransparent : colorGreyText,
                        ),
                        color: isSelected ? colorGreen : colorSecondary,
                      ),
                      child: Text(
                        topic.title.toString(),
                        style: textBody.copyWith(
                          color: isSelected ? colorSecondary : colorPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
