import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../core/config/get_it.dart';
import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/constants.dart';
import '../../core/util/time.util.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/post.repository.dart';
import '../../infrastructure/state/current_reading_post.state.dart';
import '../../infrastructure/state/my_profile.state.dart';

class ReadPostPage extends StatefulWidget {
  const ReadPostPage({super.key});

  @override
  State<ReadPostPage> createState() => _ReadPostPageState();
}

class _ReadPostPageState extends State<ReadPostPage> {
  var readingPost = null as Post?;
  final postContentJson = ValueNotifier<List<dynamic>>([]);
  final quillController = QuillController.basic();
  final likeProfiles = <Profile>[].rx;
  final comments = <Comment>[].rx;

  @override
  Future<void> didChangeDependencies() async {
    readingPost = context.provider.read(currentReadingPostProvider);
    if (readingPost?.contentUrl == null) return;
    HttpClient()
        .getUrl(Uri.parse(readingPost!.contentUrl!))
        .then((HttpClientRequest request) => request.close())
        .then(
          (HttpClientResponse response) =>
              response.transform(const Utf8Decoder()).listen(
            (contents) {
              try {
                final jsonContent = jsonDecode(contents) as List<dynamic>;
                postContentJson.value = jsonContent;
                quillController.document = Document.fromJson(jsonContent);
              } catch (e) {
                debugPrint(e as String?);
              }
            },
          ),
        );
    final postRepository = getIt.get<PostRepository>();

    final postLikeProfiles =
        await postRepository.getPostLikeProfiles(postId: readingPost!.id!);
    likeProfiles.sink.add(postLikeProfiles.data ?? []);

    final postComments =
        await postRepository.getPostComments(postId: readingPost!.id!);
    comments.sink.add(postComments.data ?? []);

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
                    readingPost?.author?.avatarUrl ?? Constants.DEFAULT_AVATAR,
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
                    const Icon(
                      Icons.favorite_border_outlined,
                      color: colorPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Like",
                      style: textLargeBody.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    StreamBuilder<List<Profile>>(
                      stream: likeProfiles.stream,
                      builder: (context, snapshot) => Text(
                        "(${likeProfiles.value.length.toString()})",
                        style: textLargeBody.copyWith(
                          color: colorGreyText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  showDialog(
                    useSafeArea: false,
                    context: context,
                    builder: (context) => SafeArea(
                      bottom: false,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: colorSecondary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Comments", style: textTitle),
                              const SizedBox(height: 16),
                              Expanded(
                                child: StreamBuilder<List<Comment>>(
                                    stream: comments.stream,
                                    builder: (context, snapshot) {
                                      return ListView.builder(
                                        itemCount: comments.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final comment = comments.value[index];
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        comment.author!
                                                                .avatarUrl ??
                                                            Constants
                                                                .DEFAULT_AVATAR,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      "${comment.author?.firstName} ${comment.author?.lastName}",
                                                      style: textBody,
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      TimeUtil.getTimeAgo(
                                                          comment.createdAt!),
                                                      style:
                                                          textCaption.copyWith(
                                                        color: colorGreyText,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  comment.content.toString(),
                                                  style: textCaption.copyWith(
                                                    color: colorGreyText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ),
                              Builder(
                                builder: (context) {
                                  final commentController = TextEditingController();
                                  return TextFormField(
                                    controller: commentController,
                                    style: textLargeBody,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      isDense: true,
                                      hintText: "Write a comment...",
                                      hintStyle: textLargeBody.copyWith(
                                          color: colorGreyText),
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
                                    onFieldSubmitted: (cmt) async {
                                      final newComment = Comment(
                                        id: null,
                                        createdAt: DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString(),
                                        content: cmt.toString(),
                                        isRepliedComment: false,
                                        repliedComments: [],
                                        author: context.provider
                                            .read(myProfileStateProvider),
                                      );
                                      comments.sink.add(
                                        [newComment, ...comments.value],
                                      );
                                      commentController.clear();
                                    },
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.messenger_outline,
                      color: colorPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Comment",
                      style: textLargeBody.copyWith(
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    StreamBuilder<List<Comment>>(
                      stream: comments.stream,
                      builder: (context, snapshot) => Text(
                        "(${comments.value.length.toString()})",
                        style: textLargeBody.copyWith(
                          color: colorGreyText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
