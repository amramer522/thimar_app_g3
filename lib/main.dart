import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thimar_app_g3/features/categories/cubit.dart';
import 'package:thimar_app_g3/features/slider/cubit.dart';

import 'firebase_options.dart';
import 'views/home_nav/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(const MyApp());
}

Future<void> init() async {
  // ask for permission

  final status = await Permission.notification.request();
  print(status.isGranted);
  if(status.isDenied)
    {
      openAppSettings();
    }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
  });
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SliderCubit()..getData(),
        ),
        BlocProvider(
          create: (BuildContext context) => CategoriesCubit()..getData(),
        ),
      ],
      child: MaterialApp(
        title: 'Thimar App',
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4C8613)),
          useMaterial3: true,
        ),
        home: HomeNavView(),
      ),
    );
  }
}
