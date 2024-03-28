import 'package:flutter/material.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../widgets/outlined_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search",
                  style: textLargeTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
