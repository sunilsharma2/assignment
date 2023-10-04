import 'package:assignment/app_screens/home_screen.dart';
import 'package:assignment/app_screens/login_screen.dart';
import 'package:assignment/res/common_widgets/error_screen.dart';
import 'package:assignment/res/common_widgets/loading_screen.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope( child: MyApp()) );
}

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);
    final sharedPref = ref.watch(sharedPreferencesProvider);
    String? userID = sharedPref.value!.getString(Strings.userID);
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: ConstantColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ConstantColors.primaryColor,
          secondary: ConstantColors.secondaryColor,
        ),
      ),
      home: initialize.when(
          data: (data) {
            if (userID != null) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
          error: (e, trace) => ErrorScreen(e, trace),
          loading: () => const LoadingScreen()),
    );
  }
}
