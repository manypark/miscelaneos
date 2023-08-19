import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {

  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body  : const _PermissionView(),
    );
  }
}

class _PermissionView extends ConsumerWidget {

  const _PermissionView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final appState = ref.watch( appStateProvider );
    final permissions = ref.watch( permissionsProvider );

    return ListView(
      children: [

        CheckboxListTile.adaptive(
          enableFeedback: true,
          value     : permissions.cameraGranted,
          title     : const Text('Camara', style: TextStyle( fontSize: 24 ),),
          subtitle  : Text('${ permissions.camera }'),
          onChanged : ( _ ) {
            ref.read(permissionsProvider.notifier).requestPermissionAccess( Permission.camera );
          },
        ),

        CheckboxListTile.adaptive(
          enableFeedback: true,
          value     : permissions.photoLibraryGranted,
          title     : const Text('Galería de fotos', style: TextStyle( fontSize: 24 ),),
          subtitle  : Text('${ permissions.photoLibrary }'),
          onChanged : ( _ ) {
            ref.read(permissionsProvider.notifier).requestPermissionAccess( Permission.photos );
          },
        ),

        CheckboxListTile.adaptive(
          enableFeedback: true,
          value     : permissions.locationGranted,
          title     : const Text('Localización', style: TextStyle( fontSize: 24 ),),
          subtitle  : Text('${ permissions.location }'),
          onChanged : ( _ ) {
            ref.read(permissionsProvider.notifier).requestPermissionAccess( Permission.location );
          },
        ),

        CheckboxListTile.adaptive(
          enableFeedback: true,
          value     : permissions.sensorsGranted,
          title     : const Text('Sensors', style: TextStyle( fontSize: 24 ),),
          subtitle  : Text('${ permissions.sensors }'),
          onChanged : ( _ ) {
            ref.read(permissionsProvider.notifier).requestPermissionAccess( Permission.sensors );
          },
        ),

      ],
    );
  }
}