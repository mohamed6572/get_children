import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:getyourchildren/cubit/cubit.dart';
import 'package:getyourchildren/cubit/states.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late BannerAd myBanner ;
  void buildBannerad(){
    myBanner =   BannerAd(
      adUnitId:///'ca-app-pub-5862074160725837/5915942281',realese
      'ca-app-pub-3940256099942544/6300978111',//test
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener:  BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    myBanner.load();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildBannerad();
  }

  bool baby = false;
  var rand = Random();
  String? image ;
  String? sound ;
  List<String> images = [
    'assets/baby1.jpg',
    'assets/baby2.jpg',
    'assets/baby3.jpg',
    'assets/Baby4.jpg',
    'assets/baby5.jpg',
  ];  List<String> sounds = [
    '1.mp3',
    '2.mp3',
    '3.mp3',
    '4.mp3',
    '5.mp3',
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
                  Spacer(),
                  Center(child: Text('${AppLocalizations.of(context)!.child}',style: TextStyle(color: Colors.black,fontSize: 24),textAlign: TextAlign.center,)),
                  SizedBox(height: 20,),
                  Center(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          maximumSize: MaterialStateProperty.all(Size(130, 40)),
                          minimumSize: MaterialStateProperty.all(Size(130, 40)),
                        ),
                        onPressed:(){
                          setState(() {
                            baby = true;
                            image =images[rand.nextInt(images.length)];
                            sound =sounds[rand.nextInt(sounds.length)];
                            try{
                              AudioCache player =
                              AudioCache(prefix: 'assets/sound/');
                              player.play(sound!);
                            }catch(error){
                              print(error);
                            }
                          });
                        } , child: Text('${AppLocalizations.of(context)!.click}',style: TextStyle(color: Colors.white,fontSize: 19),)),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: AdWidget(ad: myBanner),
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                  )
                ],
              );
            },
            fallback: (context) {

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: InkWell(
                          onTap: ()
                          {
                            setState(() {
                              baby = false;
                            });
                          },
                          child: Image(image: AssetImage('$image'))),
                    ),
                  ),
             
              Container(
              alignment: Alignment.bottomCenter,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              )
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
