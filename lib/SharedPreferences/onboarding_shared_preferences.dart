import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSharedPreferences {
  static const String _SharedPreferencesKey = 'seave';
  static late SharedPreferences _sharedPreferences;

  OnboardingSharedPreferences._();

  static OnboardingSharedPreferences? onboardingSharedPreferences;

  static Future<OnboardingSharedPreferences> init() async {
    if (onboardingSharedPreferences == null) {
      onboardingSharedPreferences = OnboardingSharedPreferences._();
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return onboardingSharedPreferences!;
  }

 static Future<void> saveBoolen(bool isSaved) async {

     await _sharedPreferences.setBool(_SharedPreferencesKey, isSaved);
  }

  static bool isSaved()  {
    return _sharedPreferences.getBool(_SharedPreferencesKey) ?? false;
  }
}
