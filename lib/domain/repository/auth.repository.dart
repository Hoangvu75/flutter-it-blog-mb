import 'package:injectable/injectable.dart';

import '../../data/api/auth/auth.api_client.dart';
import '../entities/sign_in_tokens.dart';
import '../requests/google_sign_in.request.dart';
import '../requests/sign.request.dart';
import '../responses/base.response.dart';
import 'dart:async';
import 'dart:isolate';

@lazySingleton
class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<BaseResponse<SignInTokens?>> signIn(SignRequest request) async {
    return await _runIsolate(_signInIsolate, request.toMap());
  }

  Future<BaseResponse<SignInTokens?>> googleSignIn(GoogleSignInRequest request) async {
    return await _runIsolate(_googleSignInIsolate, request.toMap());
  }

  Future<BaseResponse> signUp(SignRequest request) async {
    return await _runIsolate(_signUpIsolate, request.toMap());
  }

  Future<BaseResponse<T>> _runIsolate<T>(void Function(SendPort) isolateFunction, Map<String, dynamic> args) async {
    final responsePort = ReceivePort();
    await Isolate.spawn(isolateFunction, responsePort.sendPort);
    final sendPort = await responsePort.first as SendPort;
    final receivePort = ReceivePort();
    sendPort.send([args, receivePort.sendPort]);
    return await receivePort.first as BaseResponse<T>;
  }

  static void _signInIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) async {
      final args = message[0] as Map<String, dynamic>;
      final replyTo = message[1] as SendPort;
      final request = SignRequest.fromMap(args);
      final response = await AuthApiClient().api.signIn(request.toMap());
      replyTo.send(response);
    });
  }

  static void _googleSignInIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) async {
      final args = message[0] as Map<String, dynamic>;
      final replyTo = message[1] as SendPort;
      final request = GoogleSignInRequest.fromMap(args);
      final response = await AuthApiClient().api.googleSignIn(request.toMap());
      replyTo.send(response);
    });
  }

  static void _signUpIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) async {
      final args = message[0] as Map<String, dynamic>;
      final replyTo = message[1] as SendPort;
      final request = SignRequest.fromMap(args);
      final response = await AuthApiClient().api.signUp(request.toMap());
      replyTo.send(response);
    });
  }
}
