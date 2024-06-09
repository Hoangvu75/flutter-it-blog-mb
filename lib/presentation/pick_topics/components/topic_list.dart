import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/rx.extension.dart';
import '../../../core/firebase/google_ad_id_manager.dart';
import 'topic_item.dart';
import '../../../core/config/get_it.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/screen.ui.dart';
import '../../../domain/entities/topic.dart';
import '../../../domain/repository/topic.repository.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final topicList = <Topic>[].rx;
  final topicRepository = getIt.get<TopicRepository>();

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<List<Topic>>(
            stream: topicList.stream,
            builder: (context, snapshot) => topicList.value.isEmpty
                ? SizedBox(
                    height: screenHeight(context) * 0.5,
                    child: const Center(
                      child: CircularProgressIndicator(color: colorPrimary),
                    ),
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      topicList.value.length,
                      (index) => TopicItem(
                        topic: topicList.value[index],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
