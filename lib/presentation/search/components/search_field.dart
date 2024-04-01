import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';

import '../../../core/firebase/google_ad_id_manager.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            style: textLargeBody,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12
              ),
              isDense: true,
              hintText: "Search for any topics",
              hintStyle: textLargeBody.copyWith(color: colorGreyText),
              focusColor: colorPrimary,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: colorGreyText,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: colorPrimary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            cursorColor: colorPrimary,
            onFieldSubmitted: (_) => focusNode.unfocus(),
          ),
        ),
        const SizedBox(height: 16),
        EasyBannerAd(
          adId: adIdManager.admobAdIds!.bannerId!,
          adSize: AdSize.fullBanner,
        ),
      ],
    );
  }
}
