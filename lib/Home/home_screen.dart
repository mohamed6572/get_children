import 'dart:math';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:getyourchildren/cubit/cubit.dart';
import 'package:getyourchildren/cubit/states.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool baby = false;
  var rand = Random();
  String? image ;
  List<String> images = [
    'assets/baby1.jpg',
    'assets/baby2.jpg',
    'assets/baby3.jpg',
    'assets/Baby4.jpg',
    'assets/baby5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${AppLocalizations.of(context)!.welcome}'),
            actions: [
              TextButton(onPressed:(){
              AppCubit.get(context).changeLang();
              } , child: Text(AppCubit.get(context).isLang ? 'عر' : 'en',style: TextStyle(color: Colors.white,fontSize: 19),))
            ],
          ),
          body: BuildCondition(
            condition: baby==false,
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${AppLocalizations.of(context)!.child}',style: TextStyle(color: Colors.black,fontSize: 24),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        maximumSize: MaterialStateProperty.all(Size(130, 40)),
                        minimumSize: MaterialStateProperty.all(Size(130, 40)),
                      ),
                      onPressed:(){
                        setState(() {
                          baby = true;
                          image =images[rand.nextInt(images.length)];
                        });
                      } , child: Text('${AppLocalizations.of(context)!.click}',style: TextStyle(color: Colors.white,fontSize: 19),)),
                ],
              );
            },
            fallback: (context) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: ()
                      {
                        setState(() {
                          baby = false;
                        });
                      },
                      child: Image(image: AssetImage('$image')))
                ],
              );
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
