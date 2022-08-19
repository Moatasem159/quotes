import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/usecases/usecases.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/splash/domain/usecases/change_lang_usecase.dart';
import 'package:quotes/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_states.dart';

class LocaleCubit extends Cubit<LocaleStates> {
  LocaleCubit({required this.getSavedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.englishCode)));

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;


  String currentLangCode=AppStrings.englishCode;

  Future <void> getSavedLang() async{
    final response= await getSavedLangUseCase.call(NoParams());

    response.fold((failure) => debugPrint("cache Failure"), (value){
      currentLangCode=value;
      emit(ChangeLocaleState(Locale(currentLangCode)));

    });
  }

  Future <void> _changeLang(String langCode) async{
    final response= await changeLangUseCase.call(langCode);

    response.fold((failure) => debugPrint("cache Failure"), (value){
      currentLangCode=langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));

    });
  }


  void toEnglish()=>_changeLang(AppStrings.englishCode);
  void toArabic()=>_changeLang(AppStrings.arabicCode);
}
