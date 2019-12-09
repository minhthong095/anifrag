import 'package:Anifrag/di/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  // final container = await ComponentInjector.create(
  //     ModuleNetwork(), ModuleBloc(), ModuleStore());
  // final container = await ComponentInjector.create(ModuleNetwork());
  // container..app.componentInjector = container;
  // final app = container.app;
  // app.componentInjector = container;
  await ComponentInjector.create();
  runApp(MyApp());
}
