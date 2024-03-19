import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/repository/topic.repository.dart';
import '../../../infrastructure/state/selected_topics.state.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Consumer(builder: (context, ref, child) {
        final isOver3 = ref.watch(selectedTopicsStateProvider).length >= 3;
        return IgnorePointer(
          ignoring: !isOver3,
          child: Material(
            color: isOver3 ? colorGreen : colorDisabledGreen,
            child: InkWell(
              onTap: () {
                final topicRepository = getIt.get<TopicRepository>();
                final topicIds = ref
                    .read(selectedTopicsStateProvider)
                    .map((e) => e.id!)
                    .toList();
                topicRepository.setTopics(topicIds);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Continue",
                  textAlign: TextAlign.center,
                  style: textLargeBody.copyWith(
                    color: colorSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
