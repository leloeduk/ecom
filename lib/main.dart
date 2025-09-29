import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home/home_screen.dart';
import 'home/home_bloc.dart';
import 'cart/cart_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boutique Simple',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductBloc()),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
