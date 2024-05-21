import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/entities/topic.dart';

class PostTopicItem extends StatelessWidget {
  final Topic topic;
  final VoidCallback onClose;

  const PostTopicItem({
    super.key,
    required this.topic,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: colorPrimary,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topic.title.toString(),
            style: textBody.copyWith(
              color: colorPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          ScaleTap(
            onPressed: onClose,
            child: const Icon(
              Icons.close,
              size: 16,
              color: colorPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
