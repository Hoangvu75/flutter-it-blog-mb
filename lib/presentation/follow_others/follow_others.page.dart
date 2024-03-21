import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import 'components/continue_button.dart';
import 'components/most_followed_profiles.dart';

class FollowOthers extends StatelessWidget {
  const FollowOthers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorTransparent,
        title: Text(
          "Welcome to iTBlog",
          style: textTitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(width: screenWidth(context)),
                        Text(
                          "Recommended for you.",
                          style: textLargeTitle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Here are some top writers that you may interested in.",
                            style: textSmallTitle.copyWith(
                              color: colorGreyText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          color: colorGreyText,
                          thickness: 0.2,
                        ),
                        const SizedBox(height: 16),
                        const MostFollowedProfiles(),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: screenWidth(context),
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 32,
                      right: 32,
                      bottom: 32,
                    ),
                    decoration: const BoxDecoration(
                      color: colorSecondary,
                      border: Border(
                        top: BorderSide(
                          color: colorGreyText,
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: const ContinueButton(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
