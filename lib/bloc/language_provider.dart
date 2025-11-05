
import 'package:flutter/material.dart';
import '../SharedPreferences/language_shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{

  late Locale _local;
  AppSharedPreferences appSettingsPreferences = AppSharedPreferences.getInstance();
  LanguageProvider(){
    _local = appSettingsPreferences.getCurrentLocale();
  }

  List<Locale> getSupportedLocales(){
    return [
      Locale('en'),
      Locale('ar'),
    ];
  }
  Locale getSelectedLocale(){
    return _local;
  }
  void changeLocale(Locale newLang){
    _local = newLang;
    appSettingsPreferences.saveLocale(_local);
    notifyListeners();
  }
}