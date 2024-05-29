import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../core/extensions/context.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../core/util/time.util.dart';
import '../../domain/entities/post.dart';
import '../../infrastructure/state/current_reading_post.state.dart';

class ReadPostPage extends StatefulWidget {
  const ReadPostPage({super.key});

  @override
  State<ReadPostPage> createState() => _ReadPostPageState();
}

class _ReadPostPageState extends State<ReadPostPage> {
  var readingPost = null as Post?;
  final postContentJson = ValueNotifier<List<dynamic>>([]);
  final quillController = QuillController.basic();

  @override
  void didChangeDependencies() {
    readingPost = context.provider.read(currentReadingPostProvider);
    if (readingPost?.contentUrl == null) return;
    HttpClient()
        .getUrl(Uri.parse(readingPost!.contentUrl!))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) =>
        response.transform(const Utf8Decoder()).listen((contents) {
          try {
            final jsonContent = jsonDecode(contents) as List<dynamic>;
            postContentJson.value = jsonContent;
            quillController.document = Document.fromJson(jsonContent);
          } catch (e) {
            debugPrint(e as String?);
          }
        }));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          readingPost?.title ?? "Post Title",
          style: textTitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(
                    readingPost?.author?.avatarUrl ??
                        Constants.DEFAULT_AVATAR,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${readingPost?.author?.firstName} ${readingPost?.author?.lastName}",
                  style: textBody,
                ),
                const Spacer(),
                Text(
                  TimeUtil.getFormattedTime(
                    milliseconds: readingPost!.createdAt!,
                    format: "dd MMM yyyy",
                  ),
                  style: textCaption.copyWith(
                    color: colorGreyText,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              readingPost!.description!,
              style: textBody.copyWith(
                color: colorGreyText,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: quillController,
                  showCursor: false,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorSecondary,
          border: Border.all(
            color: colorGreyText.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorGreyText.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Like",
                      style: textLargeBody.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(0)",
                      style: textLargeBody.copyWith(
                        color: colorGreyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Comment",
                      style: textLargeBody.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(0)",
                      style: textLargeBody.copyWith(
                        color: colorGreyText,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
