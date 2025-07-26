import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/di/di.dart';
import 'features/home/data/models/photo_model.dart';
import 'features/splash/presentation/cubit/network_cubit.dart';
import 'features/home/presentation/cubit/photo_cubit.dart';
import 'features/splash/presentation/cubit/theme_cubit.dart';
import 'features/splash/presentation/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<PhotoCubit>()..fetchPhotos()),
        BlocProvider(create: (_) => NetworkCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Photo Gallery',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeState == AppTheme.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}