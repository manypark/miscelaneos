import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

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

    final appState = ref.watch( appStateProvider );

    // print(appState);

    return ListView(
      children: [

        CheckboxListTile.adaptive(
          value: true, 
          title: const Text('Camara'),
          subtitle: const Text('Estado actual'),
          onChanged : (value) {
            
          },
        ),

        ListTile(
          title: Text( '$appState' ),
        )
      ],
    );
  }
}