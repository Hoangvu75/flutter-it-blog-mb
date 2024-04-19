import 'package:flutter/material.dart';

import '../../core/extensions/context.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../infrastructure/state/my_profile.state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32, width: double.infinity),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                context.provider.read(myProfileStateProvider)?.avatarUrl ??
                    Constants.DEFAULT_AVATAR,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${context.provider.read(myProfileStateProvider)?.firstName} ${context.provider.read(myProfileStateProvider)?.lastName}',
            style: textTitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            '${context.provider.read(myProfileStateProvider)?.job}',
            style: textLargeBody.copyWith(color: colorLightGrey),
          ),
        ],
      ),
    );
  }
}
