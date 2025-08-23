

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postscleanarchitecture/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'config/theme/theme_service.dart';
import 'features/posts/application/postbloc/posts_bloc.dart';
import 'core/injection_container/injectable.dart';
import 'config/routes/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeServiceProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeServiceProvider>(
      builder: (context, themeService, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<PostsBloc>(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRoutes().router,
          ),
        );
      },
    );
  }
}