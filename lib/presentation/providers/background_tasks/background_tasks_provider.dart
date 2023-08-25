import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

final backgroundFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool? >((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicBackgroundTaskKey);
});

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  
  final String processKeyName;

  BackgroundFetchNotifier({
    required this.processKeyName,
  }) : super(false) {
    chekcCurrentStatus();
  }

  chekcCurrentStatus() async {
    state = await SharePreferencesPlugin.getBool( processKeyName ) ?? false;
  }

  toggleProcess() {

    if( state == true ) {
      desactiveProcess();
    } else {
      activaeProcess();
    }
  }

  activaeProcess() async {

    await Workmanager().registerPeriodicTask(
      processKeyName, 
      processKeyName,
      frequency: const Duration( seconds: 10 ),
      constraints: Constraints(
        networkType: NetworkType.connected
      ),
      tag: processKeyName
    );

    await SharePreferencesPlugin.setBool( processKeyName, true );
    state = true;
  }

  desactiveProcess() async {
    await Workmanager().cancelByTag( processKeyName );
    await SharePreferencesPlugin.setBool(processKeyName, false);
    state = true;
  }
  
}
