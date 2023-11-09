import 'package:authentication_app/authentication/feature/login/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'core/data/remote/rest_client.dart' as rest_client;
import 'package:authentication_app/core/di/app_injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  rest_client.init('https://dummyjson.com/');
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginWidget(),
    );
  }
}
