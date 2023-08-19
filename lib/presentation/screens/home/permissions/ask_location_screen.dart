import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';

class AskLocationScreen extends ConsumerWidget {

  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso requerido'),
      ),
      body: Center(
        child: FilledButton(
          child     : const Text('Localizacion necesaria'),
          onPressed : () {
            ref.read( permissionsProvider.notifier ).requestPermissionAccess( Permission.location );
          },
        ),
      ),
    );
  }

}
