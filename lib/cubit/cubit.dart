
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getyourchildren/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  bool isLang = true;
  String lang =' en';
  void changeLang(){
    isLang = !isLang;
    lang = isLang ? 'ar' : 'en';
    emit(AppChangeState());
  }

}
