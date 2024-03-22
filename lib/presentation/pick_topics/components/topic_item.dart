import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/entities/topic.dart';
import '../../../infrastructure/state/selected_topics.state.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;

  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {
        final selectedTopicsState = context.provider.read(
          selectedTopicsStateProvider.notifier,
        );
        if (!context.provider
            .read(selectedTopicsStateProvider)
            .contains(topic)) {
          return selectedTopicsState.addTopic(topic);
        }
        return selectedTopicsState.removeTopic(topic);
      },
      child: Consumer(
        builder: (context, ref, child) {
          final isSelected =
              ref.watch(selectedTopicsStateProvider).contains(topic);
          return Container(
            margin: const EdgeInsets.only(
              right: 8,
              bottom: 8,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}
