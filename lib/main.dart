import 'package:do_commerce/src/presentation/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/presentation/features/auth/login/pages/login_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do Commerce',
      theme: ThemeClass.lightTheme,
      home: const LoginPage(),
    );
  }
}
