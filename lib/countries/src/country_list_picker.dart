// imports

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/provider/picker_provider.dart';
import '../src/model/languages.dart';
import '../src/support/countires_multi_languages_list.dart';
import '../src/selection_list.dart';
import '../src/model/country.dart';
import '../src/model/countries.dart';
import '../src/theme/dialog_theme.dart';
import '../src/theme/input_theme.dart';
import './widget/input_field.dart';
import '../src/model/names.dart';

class CountryListPicker extends StatefulWidget {
  /// CountryListPicker is a customizable country picker for Flutter.
  /// The sizes and styles used for the picker items can be customized.
  /// The CountryListPicker allows to select a country from a list.
  /// The CountryListPicker can show many different languages.
  /// It can be customized with various properties such as [initialCountry], [language], [textDirection] and more.
  /// It has various callback properties for events such as [onCountryChanged], [onChanged] and others.
  /// It throws an error if [isShowFlag] and [isShowDiallingCode] both are set to false.
  /// note that: if 'border' property of the 'inputTheme'is not equal [InputBorder.none], the [border] will be canceled.
  /// simple code
  /// ```dart
  /// CountryListPicker(
  ///  onChanged: (value) {
  ///       // do something
  ///    },
  /// ),
  /// ```
  const CountryListPicker({
    super.key,
    // Initial
    this.initialCountry = Countries.Egypt,
    this.localCountry,
    this.language = Languages.English,
    this.textDirection,
    this.displayName = Names.common,
    // Main
    this.isShowCountryName = true,
    this.isShowFlag = true,
    this.flagSize = const Size(40.0, 40.0),
    this.isShowDiallingCode = true,
    this.iconDown = const Icon(Icons.keyboard_arrow_down, size: 24),
    this.isShowDownIcon = true,
    this.isShowInputField = true,
    // Style
    // @Deprecated("The margin variable is no longer used")
    this.margin, //= const EdgeInsets.all(5.0),
    this.padding, //= const EdgeInsets.all(0.0),
    this.border = const UnderlineInputBorder(),
    this.diallingCodeStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.countryNameStyle = const TextStyle(fontSize: 15, color: Colors.grey),
    this.dialogTheme = const DialogThemeData(),
    this.inputTheme = const InputThemeData(),
    // Events
    this.onCountryChanged,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.controller,
  }) : assert(isShowFlag == true || isShowDiallingCode == true, "Both isShowFlag and isShowCode can't be false")

  // ,assert((border == InputBorder.none || inputTheme.border == InputBorder.none),
  //     '''The 'border' variable must be set to InputBorder.none, or the 'border' property of the 'inputTheme' object must be set to InputBorder.none''')

  ;

  /// Use with the [Countries] Enumration Type to show specific intial country.
  /// Countries are identified by their name as listed below, e.g. [Countries.Egypt].
  /// default value is [Countries.Egypt]
  final Countries initialCountry;

  /// Use with the [Countries] Enumration Type to show specific local country.
  /// Countries are identified by their name as listed below, e.g. [Countries.Egypt].
  /// default value is [null]
  final Countries? localCountry;

  /// Use with the [Languages] Enumration Type to show specific language.
  /// Languages are identified by their name as listed below, e.g. [Language.Arabic].
  /// default value is [Language.English]
  final Languages language;

  /// A direction in which text flows.
  ///
  /// Some languages are written from the left to the right (for example, English,
  /// Tamil, or Chinese), while others are written from the right to the left (for
  /// example Aramaic, Hebrew, or Urdu). Some are also written in a mixture, for
  /// example Arabic is mostly written right-to-left, with numerals written
  /// left-to-right.
  ///
  /// The text direction must be provided to APIs that render text or lay out
  /// boxes horizontally, so that they can determine which direction to start in:
  /// either right-to-left, [TextDirection.rtl]; or left-to-right, [TextDirection.ltr].
  final TextDirection? textDirection;

  /// [isShowFlag] is a [bool] variable that determines whether or not to display the flag of the country.
  /// If set to true, the flage will be shown, and if set to false, the flag will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowFlag;

  /// [flagSize] is a [Size] variable that stores the size of the flag to be displayed.
  final Size flagSize;

  /// [isShowCountryName] is a [bool] variable that determines whether or not to display the title of the country.
  /// If set to true, the title will be shown, and if set to false, the title will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowCountryName;

  /// [isShowDiallingCode] is a [bool] variable that determines whether or not to display the dialling code of the country.
  /// If set to true, the dialling code will be shown, and if set to false, the dialling code will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowDiallingCode;

  /// [isShowDownIcon] is a [bool] variable that determines whether or not to display the down icon.
  /// If set to true, the down icon will be shown, and if set to false, the down icon will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowDownIcon;

  /// Creating a variable called iconDown and assigning it to the Icon class.
  final Icon iconDown;

  /// [isShowInputField] is a [bool] variable that determines whether or not to display the input field.
  /// If set to true, the input field will be shown, and if set to false, the input field will be hidden.
  /// This variable is declared as final, indicating that it can't be reassigned after being initialized.
  final bool isShowInputField;

  /// Empty space to surround the [CountryListPicker].
  final EdgeInsetsGeometry? margin;

  /// Empty space to inscribe inside the [CountryListPicker].
  final EdgeInsetsGeometry? padding;

  /// The shape of the border to be drawn around the [CountryListPicker] can be defined using the [border] variable.
  ///
  /// This variable can take on several different values including:
  ///
  /// [InputBorder.none], which means no border will be drawn.
  ///
  /// [UnderlineInputBorder], which draws a horizontal line at the bottom of the [CountryListPicker].
  ///
  /// [OutlineInputBorder], which results in a rounded rectangle being drawn around the [CountryListPicker].
  final InputBorder border;

  /// [diallingCodeStyle] text style.
  final TextStyle diallingCodeStyle;

  /// [countryNameStyle] text style.
  final TextStyle countryNameStyle;

  /// dilaog theme data
  final DialogThemeData dialogTheme;

  /// Input field theme data
  final InputThemeData inputTheme;

  ///Optional [ValueChanged] callback.
  ///
  ///Called when the user selects a new country.
  ///The callback returns the new selected country as an instance of the 'Country' class.
  final ValueChanged<Country>? onCountryChanged;

  /// Optional [ValueChanged] callback.
  ///
  /// Called as soon as the user begins typing in a phone number into the input field,
  /// it returns the current phone number as the user types"
  final ValueChanged<String>? onChanged;

  ///
  final FormFieldSetter<String>? onSaved;

  ///
  final TextEditingController? controller;

  ///
  final VoidCallback? onEditingComplete;

  ///
  final ValueChanged<String>? onFieldSubmitted;

  ///
  final GestureTapCallback? onTap;

  final Names displayName;
  @override
  State<CountryListPicker> createState() => _CountryListPickerState();
}

class _CountryListPickerState extends State<CountryListPicker> {
  Country? selectedCountry;
  bool inputOnFocus = false;
  FocusNode focusNode = FocusNode();
  List<Country> countries = [];

  @override
  Widget build(BuildContext context) {
    countriesMultiLanguagesList.removeWhere((element) => element['dialing_code'] == null);
    countries = countriesMultiLanguagesList.map((element) {
      return Country(
        iso_3166_1_alpha2: element['iso_3166_1_alpha2'],
        iso_3166_1_alpha3: element['iso_3166_1_alpha3'],
        name: (element[widget.language.iso_639_2_alpha3].runtimeType == String)
            ? Name(common: element[widget.language.iso_639_2_alpha3], official: element[widget.language.iso_639_2_alpha3])
            : Name(
                common: element[widget.language.iso_639_2_alpha3]['common'],
                official: element[widget.language.iso_639_2_alpha3]['official']),
        dialing_code: element['dialing_code'],
        default_number_length: element['default_number_length'],
        default_number_format: element['default_number_format'],
        local_number_sample: element['local_number_sample'],
        flagUri: 'assets/flags/${element['iso_3166_1_alpha2'].toLowerCase()}.png',
      );
    }).toList();
    widget.displayName == Names.common
        ? countries.sort((a, b) => a.name.common.compareTo(b.name.common))
        : countries.sort((a, b) => a.name.official.compareTo(b.name.official));

    selectedCountry = selectedCountry == null
        ? countries.firstWhere((Country e) => (e.iso_3166_1_alpha3.toUpperCase() == widget.initialCountry.iso_3166_1_alpha3.toUpperCase()),
            orElse: () => countries[0])
        : countries.firstWhere((element) => element.iso_3166_1_alpha3 == selectedCountry!.iso_3166_1_alpha3);
    return Directionality(
      textDirection: widget.textDirection ?? Directionality.of(context),
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: widget.border.isOutline ? BorderRadius.circular(4) : null,
                  border: (widget.inputTheme.border == InputBorder.none || widget.isShowInputField == false) &&
                          widget.border != InputBorder.none
                      ? widget.border.isOutline
                          ? inputOnFocus == true || widget.isShowInputField == false
                              ? Border.all(color: Theme.of(context).colorScheme.primary, width: widget.border.borderSide.width)
                              : Border.all(color: Theme.of(context).hintColor, width: 1)
                          : inputOnFocus == true || widget.isShowInputField == false
                              ? Border(
                                  bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: widget.border.borderSide.width))
                              : Border(bottom: BorderSide(color: Theme.of(context).hintColor, width: 1))
                      : null),
              child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                InkWell(
                  onTap: (widget.onCountryChanged == null) ? null : () async => await _onTapEvent(context),
                  child: _buildMainPart(selectedCountry!),
                ),
                if (widget.isShowInputField == true)
                  InputField(
                    // here worning
                    // need to take action when country changed, what can i do if input field has a value.

                    inputTheme: widget.inputTheme,
                    controller: widget.controller,
                    mask: widget.inputTheme.mask ?? selectedCountry!.default_number_format,
                    hint: widget.inputTheme.hintText ?? selectedCountry!.local_number_sample,
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        String unMaskedText = MaskTextInputFormatter(
                            mask: widget.inputTheme.mask == null ? widget.inputTheme.mask : selectedCountry!.default_number_format,
                            initialText: value,
                            filter: {"#": RegExp(r'[0-9]')}).getUnmaskedText();

                        widget.onChanged!("${selectedCountry!.dialing_code}$unMaskedText");
                      }
                    },
                    onEditingComplete: widget.onEditingComplete,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    onSaved: widget.onSaved,
                    onTap: widget.onTap,
                    focusNode: focusNode
                      ..addListener(() {
                        inputOnFocus = focusNode.hasFocus;
                        setState(() {});
                      }),
                  ),
              ]),
            ),
            if (widget.isShowCountryName == true)
              Text(
                selectedCountry != null
                    ? (widget.displayName == Names.common)
                        ? selectedCountry!.name.common
                        : selectedCountry!.name.official
                    : (widget.displayName == Names.common)
                        ? countries
                            .firstWhere(
                                (Country e) => (e.iso_3166_1_alpha3.toUpperCase() == widget.initialCountry.iso_3166_1_alpha3.toUpperCase()),
                                orElse: () => countries[0])
                            .name
                            .common
                        : countries
                            .firstWhere(
                                (Country e) => (e.iso_3166_1_alpha3.toUpperCase() == widget.initialCountry.iso_3166_1_alpha3.toUpperCase()),
                                orElse: () => countries[0])
                            .name
                            .official,
                style: widget.countryNameStyle.copyWith(
                    fontWeight: widget.countryNameStyle.fontWeight,
                    fontSize: widget.countryNameStyle.fontSize ?? 15,
                    color: widget.countryNameStyle.color ?? Colors.grey,
                    overflow: TextOverflow.ellipsis),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapEvent(BuildContext context) async {
    final Country? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<SettingsProvider>(
                  create: (_) => SettingsProvider(elements: countries),
                  builder: (_, child) {
                    return SelectionList(
                      countries,
                      displayName: widget.displayName,
                      language: widget.language,
                      textDirection: widget.textDirection ?? Directionality.of(context),
                      selectedCountry: selectedCountry!,
                      localCountry: (widget.localCountry == null)
                          ? null
                          : countries.firstWhere(
                              (Country e) => (e.iso_3166_1_alpha3.toUpperCase() == widget.localCountry!.iso_3166_1_alpha3.toUpperCase()),
                            ),
                      appBar: widget.dialogTheme.appBar ??
                          AppBar(
                              // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                              title: const Text("Select your country")),
                      dialogTheme: widget.dialogTheme,
                    );
                  },
                )));

    if (result != null) {
      selectedCountry = result;
      if (widget.onCountryChanged != null) {
        widget.onCountryChanged!(selectedCountry!);
      }
      setState(() {});
    }
  }

  Row _buildMainPart(Country country) {
    return Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
      //flage
      if (widget.isShowFlag == true)
        Flexible(
            child: Image.asset("assets/flags/${country.iso_3166_1_alpha2.toLowerCase()}.png",
                package: "country_list_picker", fit: BoxFit.fill, height: widget.flagSize.height, width: widget.flagSize.width)),
      //code
      if (widget.isShowDiallingCode == true)
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.5),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(country.dialing_code.toString(),
                  style: widget.diallingCodeStyle.copyWith(
                      color: widget.diallingCodeStyle.color ?? Theme.of(context).textTheme.titleLarge?.color,
                      fontSize: widget.diallingCodeStyle.fontSize ?? 16,
                      fontWeight: widget.diallingCodeStyle.fontWeight ?? FontWeight.bold)),
            )),

      //down icon
      if (widget.isShowDownIcon == true)
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 5.5),
        // child:
        Icon(
          widget.iconDown.icon,
          size: widget.iconDown.size,
          color: (widget.iconDown.color) ?? Theme.of(context).colorScheme.primary,
          semanticLabel: widget.iconDown.semanticLabel,
          textDirection: widget.iconDown.textDirection,
          shadows: widget.iconDown.shadows,
          key: widget.iconDown.key,
          // )
        ),
    ]);
  }
}
