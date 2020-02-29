import 'package:flutter_driver/driver_extension.dart';
import 'package:nice_travel/main.dart'  as app;
import 'package:wakelock/wakelock.dart';

void main() {
  // This line enables the extension.
  // ignore: missing_return

  enableFlutterDriverExtension();
  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  Wakelock.enable();
  app.main(testMode: true);
}
