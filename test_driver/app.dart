import 'package:flutter_driver/driver_extension.dart';
import 'package:nice_travel/main.dart'  as app;

void main() {
  // This line enables the extension.
  // ignore: missing_return

  enableFlutterDriverExtension();
  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main(testMode: true);
}
