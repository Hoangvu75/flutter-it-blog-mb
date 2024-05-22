import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_embeds.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/file_helper.dart';
import '../../infrastructure/routing/app_pages.dart';
import '../../infrastructure/state/creating_post.state.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final quillController = QuillController.basic();
  var contentFile = null as File?;
  final fileHelper = FileHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create new post",
          style: textTitle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              contentFile = await fileHelper.createFile(
                jsonEncode(quillController.document.toDelta().toJson())
                    .toString(),
              );
              navContext?.provider
                  .read(creatingPostStateProvider.notifier)
                  .setContent(
                    contentFile,
                  );
              await navContext?.push(Routes.UPLOAD_POST);
            },
            icon: const Icon(
              Icons.check,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: quillController,
                  showCursor: true,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: quillController,
                showDividers: false,
                multiRowsDisplay: true,
                color: colorRed,
                showClipboardCopy: false,
                showClipboardPaste: false,
                showClipboardCut: false,
                showUndo: false,
                showRedo: false,
                showListCheck: false,
                showCodeBlock: false,
                showHeaderStyle: false,
                showSubscript: false,
                showSuperscript: false,
                showAlignmentButtons: true,
                showClearFormat: false,
                sectionDividerSpace: 0,
                showIndent: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
