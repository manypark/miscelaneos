import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

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

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith( camera: status );

    if( status == PermissionStatus.permanentlyDenied ) {
      openAppSettings();
    }
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