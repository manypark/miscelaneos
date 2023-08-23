import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/config/config.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

final localAuthProvider = StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
});

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {

  LocalAuthNotifier():super( LocalAuthState() );

  Future<( bool, String )> authenticateUser() async {

    final ( didAuthenticate, message ) = await LocalAuthPlugin.authenticate( biometricOnly: true );

    state = state.copyWith( 
      didAuthenticate : didAuthenticate, 
      message         : message,
      status          : didAuthenticate ? LocalAuthStatus.authenticated : LocalAuthStatus.notauthenticated
    );

    return ( didAuthenticate, message );
  }
  
}

enum LocalAuthStatus { authenticated, notauthenticated, authenticating }

class LocalAuthState {

  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
    this.didAuthenticate = false,
    this.status = LocalAuthStatus.notauthenticated,
    this.message = '',
  });
  

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthState(
      status          : status ?? this.status,
      message         : message ?? this.message,
      didAuthenticate : didAuthenticate ?? this.didAuthenticate,
    );
  }
  

  @override
  String toString() => '''
  didAuthenticate: $didAuthenticate
  status: $status
  message: $message
  ''';
}
