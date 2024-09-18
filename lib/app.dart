import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_bridge_assignment/src/blocs/add%20pets/add_pets_bloc.dart';
import 'package:omni_bridge_assignment/src/blocs/auth/login/login_bloc.dart';
import 'package:omni_bridge_assignment/src/blocs/auth/register/register_bloc.dart';
import 'package:omni_bridge_assignment/src/blocs/get_pets/get_pets_bloc.dart';
import 'package:omni_bridge_assignment/src/core/routes.dart';
import 'package:omni_bridge_assignment/src/core/theme.dart';
import 'package:omni_bridge_assignment/src/ui/screens/splash_screen.dart';

import 'src/blocs/bottom nav/bottom_nav_cubit.dart';
import 'src/blocs/profile/profile_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => AddPetsBloc()),
        BlocProvider(create: (context) => GetPetsBloc()),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
