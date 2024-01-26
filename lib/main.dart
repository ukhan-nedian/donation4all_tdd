import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in/sign_in.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donation TDD',
      home: BlocProvider<SignInBloc>(
        create: (_) => locator<SignInBloc>(),
        child: const SignInScreen(),
      ),
    );
  }
}
