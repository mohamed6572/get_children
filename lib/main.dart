import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:getyourchildren/cubit/cubit.dart';
import 'package:getyourchildren/cubit/states.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'Bloc_Observer.dart';
import 'Home/home_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      MobileAds.instance.initialize();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
         listener: (context, state) {},
      builder: (context, state) {
        return   MaterialApp(
          title: 'get your children',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(AppCubit.get(context).lang),
          home:  MyHomePage(),
        );
      },
      ),
    );
  }
}
