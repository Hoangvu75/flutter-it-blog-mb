import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/screen.ui.dart';
import '../../core/ui/text.ui.dart';
import '../widgets/green_button.dart';
import 'components/continue_button.dart';
import 'components/topic_list.dart';

class PickTopicsPage extends StatelessWidget {
  const PickTopicsPage({super.key});

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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: screenWidth(context)),
                  Text(
                    "What are you interested in?",
                    style: textLargeTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Choose three or more.",
                    style: textSmallTitle.copyWith(
                      color: colorGreyText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TopicList()
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
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
                child: const ContinueButton()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
