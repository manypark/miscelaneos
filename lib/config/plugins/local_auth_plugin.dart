import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {

   static final LocalAuthentication auth = LocalAuthentication();

   static availableBiometrics() async {

      final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        
      }

      if ( availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {

      }

   }

   static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
   }

   static Future<( bool, String )> authenticate( { bool biometricOnly = false } ) async {

      try {
        
        final bool didAuthenticate = await auth.authenticate(
          localizedReason : 'Por favor autenticate para continuar',
          options         : AuthenticationOptions(
            biometricOnly: biometricOnly // si es falso podemos colocar PIN
          ),
        );

        return (didAuthenticate, didAuthenticate ? 'Hecho' : 'Cancelado por usuario');

      } on PlatformException catch (e) {


        if( e.code == auth_error.notEnrolled ) return ( false, 'No hay biometricos enrrolados' );
        if( e.code == auth_error.lockedOut ) return ( false, 'Muchos intentos fallidos' );
        if( e.code == auth_error.notAvailable ) return ( false, 'No hay biometricos' );
        if( e.code == auth_error.passcodeNotSet ) return ( false, 'No hay un PIN configurado' );
        if( e.code == auth_error.permanentlyLockedOut ) return ( false, 'Totalmente bloqueado, usa tu codigo de desbloqueo' );

        return ( false, e.toString());
      }

   }
  
}