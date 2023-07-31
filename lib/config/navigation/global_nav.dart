import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../../domain/entities/special.dart';
import '../../domain/entities/settings_data.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/section.dart';
import 'app_navigation.dart';

class GlobalNav {
  late final SharedPreferences? sharedPreferences;

  static final GlobalNav instance = GlobalNav._internal();

  factory GlobalNav() => instance;

  GlobalNav._internal();
  late List<Special> specials;
  late List<Section> sections;
  SettingsData? settingsData;
  List<Question>? questions;
  late final AppNavigation appNavigation;

  init() async {
    appNavigation = AppNavigation();
    sharedPreferences = await SharedPreferences.getInstance();
    setUpShared(sharedPreferences!);
  }
}

void setUpShared(SharedPreferences sharedPreferences) {
  // User_id the unique identifier of the user
  bool? truthSettings = sharedPreferences.getBool(AppConstants.truthSettingsKey);
  if (truthSettings == null) sharedPreferences.setBool(AppConstants.truthSettingsKey, AppConstants.truthSettings);
  bool? soundSettings = sharedPreferences.getBool(AppConstants.soundsKey);
  if (soundSettings == null) sharedPreferences.setBool(AppConstants.soundsKey, AppConstants.sounds);
  String? specialSettings = sharedPreferences.getString(AppConstants.specialKey);
  if (specialSettings == null) sharedPreferences.setString(AppConstants.specialKey, AppConstants.specialStart);
}
