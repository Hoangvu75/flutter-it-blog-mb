import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../core/ui/text.ui.dart';

class SignButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function() onTap;

  const SignButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          width: screenWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorTransparent,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: colorPrimary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
              Text(
                title,
                style: textSmallTitle,
              ),
              const SizedBox(width: 20)
            ],
          ),
        ),
      ),
    );
  }
}
