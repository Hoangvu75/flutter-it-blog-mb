import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/repository/topic.repository.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/my_profile.state.dart';
import '../../../infrastructure/state/selected_topics.state.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

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
                context.pop();
                final topicRepository = getIt.get<TopicRepository>();
                final topicIds = ref
                    .read(selectedTopicsStateProvider)
                    .map((e) => e.id!)
                    .toList();
                topicRepository.setTopics(topicIds);
                context.provider
                    .read(myProfileStateProvider.notifier)
                    .setTopics(ref.read(selectedTopicsStateProvider).toList());
                EasyLoading.showSuccess("Topics saved successfully");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Confirm",
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
