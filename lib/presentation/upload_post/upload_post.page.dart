import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/config/get_it.dart';
import '../../core/extensions/context.extension.dart';
import '../../core/extensions/rx.extension.dart';
import '../../core/ui/color.ui.dart';
import '../../core/ui/text.ui.dart';
import '../../core/util/file_helper.dart';
import '../../domain/entities/topic.dart';
import '../../domain/repository/post.repository.dart';
import '../../domain/repository/topic.repository.dart';
import '../../infrastructure/state/creating_post.state.dart';
import 'components/post_topic_item.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  final topicList = <Topic>[].rx;
  final topicRepository = getIt.get<TopicRepository>();
  final myTopics = <Topic>[].rx;
  final thumbnailImage = (null as XFile?).rx;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final postRepository = getIt.get<PostRepository>();
  final fileHelper = FileHelper();

  @override
  void initState() {
    fetchTopics();
    super.initState();
  }

  Future<void> fetchTopics() async {
    final response = await topicRepository.getTopics();
    if (response.success == true && response.data != null) {
      topicList.sink.add(response.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Upload your post",
            style: textTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          child: ScaleTap(
            onPressed: () async {
              context.provider.read(creatingPostStateProvider.notifier)
                ..setTitle(titleController.text)
                ..setDescription(descriptionController.text)
                ..setTopicIds(myTopics.value.map((e) => e.id!).toList())
                ..setThumbnail(File(thumbnailImage.value!.path));
              await postRepository.createPost(
                creatingPost: context.provider.read(creatingPostStateProvider),
              );
              await fileHelper.deleteContentFile();
              await fileHelper.deleteFile(thumbnailImage.value!.path);
            },
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  "Confirm",
                  style: textLargeBody.copyWith(
                    color: colorSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter your post title",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                  cursorColor: colorPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Enter your post description",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                  cursorColor: colorPrimary,
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Choose topics",
                  style: textLargeBody.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder<List<Topic>>(
                  stream: myTopics.stream,
                  builder: (context, snapshot) {
                    return Wrap(
                      children: [
                        ScaleTap(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Choose a topic"),
                                  content: SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: StreamBuilder<List<Topic>>(
                                        stream: topicList.stream,
                                        builder: (context, snapshot) {
                                          if (topicList.value.isEmpty) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: colorPrimary,
                                              ),
                                            );
                                          }
                                          return ListView.builder(
                                            itemCount: topicList.value.length,
                                            itemBuilder: (context, index) {
                                              final topic =
                                                  topicList.value[index];
                                              return ListTile(
                                                title: Text(
                                                    topic.title.toString()),
                                                onTap: () {
                                                  myTopics.sink.add(
                                                    myTopics.value..add(topic),
                                                  );
                                                  topicList.sink.add(
                                                    topicList.value
                                                      ..remove(topic),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: colorPrimary,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...List.generate(
                          myTopics.value.length,
                          (index) => PostTopicItem(
                            key: ValueKey(myTopics.value[index].id),
                            topic: myTopics.value[index],
                            onClose: () {
                              myTopics.sink.add(
                                myTopics.value..removeAt(index),
                              );
                              topicList.sink.add(
                                topicList.value..add(myTopics.value[index]),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Thumbnail image",
                  style: textLargeBody.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final imagePicker = ImagePicker();
                    final image = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    thumbnailImage.sink.add(image);
                  },
                  child: StreamBuilder<XFile?>(
                      stream: thumbnailImage.stream,
                      builder: (context, snapshot) {
                        if (thumbnailImage.value != null) {
                          return Container(
                            width: 240,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: FileImage(
                                  File(thumbnailImage.value!.path),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: 240,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colorPrimary,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Tap to choose an image",
                              style: textBody.copyWith(
                                color: colorGreyText,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
