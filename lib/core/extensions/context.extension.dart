import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ContextExtension on BuildContext {
  ProviderContainer get provider => ProviderScope.containerOf(this);
}
