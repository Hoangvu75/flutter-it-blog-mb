import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';

import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../infrastructure/routing/app_pages.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final quillController = QuillController.basic();

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
            onPressed: () async => await context.push(Routes.UPLOAD_POST),
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
