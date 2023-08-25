import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'menu.dev.miscelaneo.fecth-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'menu.dev.miscelaneo.fecth-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch ( task ) {

      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
      break;

      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
      break;

      case Workmanager.iOSBackgroundTask:
       print('Workmanager.iOSBackgroundTask');
      break;
    }

    return true;
    // print("Native called background task: $task");
    // return Future.value(true);
  });

}
