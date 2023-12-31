import 'package:flutter/material.dart';
import '../domain/entities/settings_data.dart';
import '../config/enums.dart';
import '../config/navigation/global_nav.dart';
import '../config/constants.dart';
import '../config/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences = GlobalNav.instance.sharedPreferences!;

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void resetSettings() {
    setState(() {});
  }

  late bool truthSettings;
  late bool soundSettings;
  late bool randomAnswerSettings;
  SettingsData? settingsData;
  GlobalNav globalNav = GlobalNav.instance;
  late String showValue;

  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;
  @override
  void initState() {
    truthSettings = sharedPreferences.getBool(AppConstants.truthSettingsKey)!;
    soundSettings = sharedPreferences.getBool(AppConstants.soundsKey)!;
    randomAnswerSettings = sharedPreferences.getBool(AppConstants.randomAnswersKey)!;
    showValue = sharedPreferences.getString(AppConstants.notLeartSettingsKey)!;
    settingsData = globalNav.settingsData!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(resetSettings, settingsData!),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Truthful Questions only'),
              value: truthSettings,
              onChanged: (value) {
                setState(() {
                  sharedPreferences.setBool(AppConstants.truthSettingsKey, value);
                  truthSettings = value;
                });
              },
            ),
            const SizedBox(height: 40),
            SwitchListTile(
              title: const Text('Play Sounds'),
              value: soundSettings,
              onChanged: (value) {
                setState(() {
                  sharedPreferences.setBool(AppConstants.soundsKey, value);
                  soundSettings = value;
                });
              },
            ),
            const SizedBox(height: 40),
            SwitchListTile(
              title: const Text('Random Answers'),
              value: randomAnswerSettings,
              onChanged: (value) {
                setState(() {
                  sharedPreferences.setBool(AppConstants.randomAnswersKey, value);
                  randomAnswerSettings = value;
                });
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                Expanded(child: Text('Show only', style: getPrimary(context, 16))),
                getStatusDropdown(),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget createAppBar(VoidCallback resetSettings, SettingsData settingsData) {
    return AppBar(
      title: const Text('Settings'),
      actions: !showMediumSizeLayout && !showLargeSizeLayout
          ? [
              _BrightnessButton(
                handleBrightnessChange: settingsData.handleBrightnessChange,
              ),
              _ColorSeedButton(
                resetSettings: resetSettings,
                handleColorSelect: settingsData.handleColorSelect,
                colorSelected: settingsData.colorSelected,
                colorSelectionMethod: settingsData.colorSelectionMethod,
              ),
              _ColorImageButton(
                handleImageSelect: settingsData.handleImageSelect,
                imageSelected: settingsData.imageSelected,
                colorSelectionMethod: settingsData.colorSelectionMethod,
              )
            ]
          : [Container()],
    );
  }

  Widget getStatusDropdown() {
    return LimitedBox(
      maxWidth: 120,
      maxHeight: 56,
      child: DropdownButtonFormField<String>(
        value: showValue,
        style: getPrimary(context, 16),
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(),
        ),
        items: quantities,
        menuMaxHeight: 300,
        onChanged: (value) {
          showValue = value!;
          globalNav.sharedPreferences!.setString(AppConstants.notLeartSettingsKey, showValue);
        },
      ),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright ? const Icon(Icons.dark_mode_outlined) : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}

class _ColorSeedButton extends StatelessWidget {
  const _ColorSeedButton({
    required this.resetSettings,
    required this.handleColorSelect,
    required this.colorSelected,
    required this.colorSelectionMethod,
  });
  final VoidCallback resetSettings;
  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.palette_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a seed color',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorSeed.values.length, (index) {
          ColorSeed currentColor = ColorSeed.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentColor != colorSelected || colorSelectionMethod != ColorSelectionMethod.colorSeed,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    currentColor == colorSelected && colorSelectionMethod != ColorSelectionMethod.image
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                    color: currentColor.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentColor.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: (value) {
        handleColorSelect(value);
        resetSettings();
      },
    );
  }
}

class _ColorImageButton extends StatelessWidget {
  const _ColorImageButton({
    required this.handleImageSelect,
    required this.imageSelected,
    required this.colorSelectionMethod,
  });

  final void Function(int) handleImageSelect;
  final ColorImageProvider imageSelected;
  final ColorSelectionMethod colorSelectionMethod;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.image_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Select a color extraction image',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) {
        return List.generate(ColorImageProvider.values.length, (index) {
          ColorImageProvider currentImageProvider = ColorImageProvider.values[index];

          return PopupMenuItem(
            value: index,
            enabled: currentImageProvider != imageSelected || colorSelectionMethod != ColorSelectionMethod.image,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 48),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          image: NetworkImage(ColorImageProvider.values[index].url),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(currentImageProvider.label),
                ),
              ],
            ),
          );
        });
      },
      onSelected: handleImageSelect,
    );
  }
}
