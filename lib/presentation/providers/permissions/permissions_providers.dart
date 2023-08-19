import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider = StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier(); 
});

class PermissionNotifier extends StateNotifier<PermissionState> {

  PermissionNotifier(): super( PermissionState() ) {
    checkPermission();
  }

  Future<void> checkPermission() async {

    final permissionArray = await Future.wait([

      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,

      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera            : permissionArray[0],
      photoLibrary      : permissionArray[1],
      sensors           : permissionArray[2],
      location          : permissionArray[3],
      locationAlways    : permissionArray[4],
      locationWhenInUse : permissionArray[5],
    );
  }

  requestPermissionAccess( Permission permission ) async {

    final status = await permission.request();

    switch (permission) {

      case Permission.camera:
        state = state.copyWith( camera: status );
      break;

      case Permission.photos:
        state = state.copyWith( photoLibrary: status );
      break;
      
      case Permission.location:
        state = state.copyWith( location: status );
      break;

      case Permission.sensors:
        state = state.copyWith( sensors: status );
      break;

    }

    if( status == PermissionStatus.permanentlyDenied ) openAppSettings();

  }
  
}

class PermissionState {

  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionState({
    this.camera           = PermissionStatus.denied,
    this.photoLibrary     = PermissionStatus.denied,
    this.sensors          = PermissionStatus.denied,
    this.location         = PermissionStatus.denied,
    this.locationAlways   = PermissionStatus.denied,
    this.locationWhenInUse= PermissionStatus.denied,
  });

  get cameraGranted {
    return camera ==  PermissionStatus.granted;
  }

  get photoLibraryGranted {
    return photoLibrary ==  PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors ==  PermissionStatus.granted;
  }

  get locationGranted {
    return location ==  PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways ==  PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse ==  PermissionStatus.granted;
  }

  copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionState(
    camera            : camera            ?? this.camera,
    photoLibrary      : photoLibrary      ?? this.photoLibrary,
    sensors           : sensors           ?? this.sensors,
    location          : location          ?? this.location,
    locationAlways    : locationAlways    ?? this.locationAlways,
    locationWhenInUse : locationWhenInUse ?? this.locationWhenInUse,
  );
  
}