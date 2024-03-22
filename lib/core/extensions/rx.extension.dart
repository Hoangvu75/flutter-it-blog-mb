import 'package:rxdart/rxdart.dart';

class Rx<T> {
  final BehaviorSubject<T> _subject;

  Rx(T value) : _subject = BehaviorSubject<T>.seeded(value);

  BehaviorSubject<T> get subject => _subject;
}

extension RxExtension<T> on T {
  BehaviorSubject<T> get rx => Rx<T>(this).subject;
}
