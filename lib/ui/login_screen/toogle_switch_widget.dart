
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../bloc/language_provider.dart';
import '../../core/colors/app_color.dart';
import '../../core/icons/app_icon.dart';


class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});


  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return AnimatedToggleSwitch<Locale>.
    rolling(current: languageProvider.getSelectedLocale(),
      values: languageProvider.getSupportedLocales(),
      onChanged: (item) {
        setState(() {
          languageProvider.changeLocale(item);
        });
      },
      iconBuilder: (value, foreground) {
        if(value == Locale('en')){
          return SvgPicture.asset(AppIcon.ic_us, width: 35);
        } else {
          return SvgPicture.asset(AppIcon.ic_eg, width: 35);
        }
      },
      style: ToggleStyle(
        indicatorBorder: BoxBorder.all(
          width: 3,
          color: AppColor.yellow,
        ),
        indicatorColor: AppColor.yellow ,
        backgroundColor: Colors.transparent ,
        borderColor:AppColor.yellow ,
      ),
    );
  }
}
