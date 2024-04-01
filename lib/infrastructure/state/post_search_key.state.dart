import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_search_key.state.g.dart';

@riverpod
class PostSearchKey extends _$PostSearchKey {
  @override
  String? build() {
    return null;
  }

  void setSearchKey(String? key) {
    state = key;
  }
}
