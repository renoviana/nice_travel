

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

isPresent(SerializableFinder finder, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 2)}) async {
  try {
    await driver.waitFor(finder, timeout: timeout);
    return true;
  } catch (exception) {
    print('Erro ao buscar o elemento: ${finder.finderType}');
    return false;
  }
}

Future verifyIfPresent(
    FlutterDriver driver, SerializableFinder scheduleList) async {
  expect(await isPresent(scheduleList, driver), isTrue);
}

tapWithDelay(FlutterDriver driver, SerializableFinder button) async {
  expect(await isPresent(button, driver), isTrue);
  await driver.tap(button);
  sleep(const Duration(seconds: 1));
}

void sleepEndTest({int duration = 1}) {
  sleep(Duration(seconds: duration));
}

Future enterText(FlutterDriver driver, SerializableFinder scheduleNameField,
    String text) async {
  await tapWithDelay(driver, scheduleNameField);
  driver.enterText(text);
  sleep(const Duration(milliseconds: 1500));
}
