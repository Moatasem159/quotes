import 'package:quotes/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LangLocaleDataSource {
  Future<bool> changeLang({required String langCode});

  Future<String?> getSavedLang();
}


class LangLocaleDataSourceImpl implements LangLocaleDataSource{

  final SharedPreferences sharedPreferences;

  LangLocaleDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> changeLang({required String langCode}) async{

  return await sharedPreferences.setString(AppStrings.locale, langCode);
  }

  @override
  Future<String?> getSavedLang() async=>
   sharedPreferences.containsKey(AppStrings.locale)?
       sharedPreferences.getString(AppStrings.locale):AppStrings.englishCode;




}