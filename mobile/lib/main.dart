import 'package:flutter/material.dart';

import 'app.dart';
import 'common/injector_module.dart';
import 'common/widgets/global_bloc_provider.dart';

Future<void> main() async {
  await InjectorModule.inject();

  runApp(
    const GlobalBlocProvider(
      child: Application(),
    ),
  );
}
