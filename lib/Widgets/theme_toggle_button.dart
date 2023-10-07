import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:kava_beats_app/Provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: primaryClr,
      activeTrackColor: primaryClr.withOpacity(0.3),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey.withOpacity(0.3),
      onChanged: (value) async{
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
