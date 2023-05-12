import 'package:flutter/material.dart';
import 'package:country_list_picker/country_list_picker.dart';
import '../model/borders.dart';
import '../translation.dart';
import '../widget/color_picker.dart';

class CustomListTile<Object, T> extends StatelessWidget {
  final bool enabled;
  final String title;
  final String? subTitle;
  final T value;
  final ValueChanged<T>? onChanged;
  final ValueChanged<IconData>? onIconChanged;
  final ValueChanged<Borders>? onStringChanged;
  final ValueChanged<Countries>? onCountiresChanged;
  final ValueChanged<Languages>? onLanguagesChanged;
  final ValueChanged<TextDirection>? ontextDirectionChanged;
  //Slider arguments
  final double min;
  final double max;
  final String? sliderLabel;
  final int? divisions;
  final List<IconData> iconsList;
  final TextDirection? textDirection;
  const CustomListTile({
    super.key,
    required this.title,
    this.subTitle,
    this.enabled = true,
    required this.value,
    this.onChanged,
    this.onIconChanged,
    this.onStringChanged,
    this.onCountiresChanged,
    this.onLanguagesChanged,
    this.ontextDirectionChanged,
    this.min = 1,
    this.max = 100,
    this.sliderLabel,
    this.divisions,
    this.textDirection,
    this.iconsList = const [
      Icons.check,
      Icons.star,
      Icons.circle,
      Icons.ac_unit,
      Icons.add,
      Icons.arrow_back,
      Icons.arrow_back_ios_new,
      Icons.arrow_circle_left_outlined,
      Icons.keyboard_double_arrow_left_rounded,
      Icons.subdirectory_arrow_left_outlined
    ],
  });
  @override
  Widget build(BuildContext context) {
    switch (Object) {
      case TextFormField:
        return _buildTextFormFiled(context);
      case ColorPicker:
        return _buildColorPickerTile(context);
      case Switch:
        return _buildSwitchListTile(context);
      case Slider:
        return _buildSlideristTile(context);
      case DropdownButtonFormField:
        return _buildDropdownButtonFormField(context);

      default:
        return const SizedBox.shrink();
    }
  }

  ListTile _buildColorPickerTile(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(title.tr,
          style: TextStyle(
              color: enabled == true ? null : Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold)),
      subtitle: ColorPicker(
        enabled: enabled,
        value: value as Color,
        onColorChanged: onChanged as ValueChanged<Color>,
      ),
    );
  }

  Widget _buildDropdownButtonFormField(BuildContext context) {
    switch (T) {
      case IconData:
        return ListTile(
          enabled: enabled,
          title: Text(title.tr,
              style: TextStyle(
                  color:
                      enabled == true ? null : Theme.of(context).disabledColor,
                  fontWeight: FontWeight.bold)),
          subtitle: DropdownButtonFormField<IconData>(
            decoration: InputDecoration(enabled: enabled),
            value: value as IconData,
            items: iconsList
                .map<DropdownMenuItem<IconData>>(
                  (e) => DropdownMenuItem<IconData>(
                      value: e,
                      child: Icon(e,
                          color: Theme.of(context).colorScheme.primary)),
                )
                .toList(),
            onChanged: ((value) => onIconChanged!(value!)),
          ),
        );
      case Borders:
        return ListTile(
            enabled: enabled,
            title: Text(title.tr,
                style: TextStyle(
                    color: enabled == true
                        ? null
                        : Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold)),
            subtitle: DropdownButtonFormField<Borders>(
              decoration: InputDecoration(enabled: enabled),
              value: value as Borders,
              items: Borders.values
                  .map<DropdownMenuItem<Borders>>(
                    (e) => DropdownMenuItem<Borders>(
                        value: e, child: Text(e.name)),
                  )
                  .toList(),
              onChanged: enabled == true
                  ? ((value) => onStringChanged!(value!))
                  : null,
            ));
      case Countries:
        return ListTile(
            enabled: enabled,
            title: Text(title.tr,
                style: TextStyle(
                    color: enabled == true
                        ? null
                        : Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold)),
            subtitle: DropdownButtonFormField<Countries>(
              decoration: InputDecoration(enabled: enabled),
              value: value as Countries,
              items: Countries.values
                  .map<DropdownMenuItem<Countries>>(
                    (e) => DropdownMenuItem<Countries>(
                      value: e,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(e.name, overflow: TextOverflow.ellipsis)),
                    ),
                  )
                  .toList(),
              onChanged: enabled == true
                  ? ((value) => onCountiresChanged!(value!))
                  : null,
            ));
      case Languages:
        return ListTile(
            enabled: enabled,
            title: Text(title.tr,
                style: TextStyle(
                    color: enabled == true
                        ? null
                        : Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold)),
            subtitle: DropdownButtonFormField<Languages>(
              decoration: InputDecoration(enabled: enabled),
              value: value as Languages,
              items: Languages.values
                  .map<DropdownMenuItem<Languages>>(
                    (e) => DropdownMenuItem<Languages>(
                      value: e,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(e.name, overflow: TextOverflow.ellipsis)),
                    ),
                  )
                  .toList(),
              onChanged: enabled == true
                  ? ((value) => onLanguagesChanged!(value!))
                  : null,
            ));
      case TextDirection:
        return ListTile(
            enabled: enabled,
            title: Text(title.tr,
                style: TextStyle(
                    color: enabled == true
                        ? null
                        : Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold)),
            subtitle: DropdownButtonFormField<TextDirection>(
              decoration: InputDecoration(enabled: enabled),
              value: value as TextDirection,
              items: TextDirection.values
                  .map<DropdownMenuItem<TextDirection>>(
                    (e) => DropdownMenuItem<TextDirection>(
                      value: e,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(e.name, overflow: TextOverflow.ellipsis)),
                    ),
                  )
                  .toList(),
              onChanged: enabled == true
                  ? ((value) => ontextDirectionChanged!(value!))
                  : null,
            ));
      default:
        return const SizedBox.shrink();
    }
  }

  ListTile _buildSlideristTile(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(title.tr,
          style: TextStyle(
              color: enabled == true ? null : Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold)),
      subtitle: Slider(
        divisions: divisions,
        label: sliderLabel,
        min: min,
        max: max,
        value: value as double,
        onChanged: (enabled) ? onChanged as ValueChanged<double> : null,
      ),
    );
  }

  ListTile _buildSwitchListTile(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(title.tr,
          style: TextStyle(
              color: enabled == true ? null : Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold)),
      trailing: Switch(
        value: value as bool,
        onChanged: (enabled) ? onChanged as ValueChanged<bool> : null,
      ),
    );
  }

  ListTile _buildTextFormFiled(BuildContext context) {
    return ListTile(
      enabled: enabled,
      title: Text(title.tr,
          style: TextStyle(
              color: enabled == true ? null : Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold)),
      subtitle: TextFormField(
        textAlign: textDirection == null ? TextAlign.start : TextAlign.left,
        decoration: InputDecoration(enabled: enabled),
        maxLength: max.toInt(),
        initialValue: value as String,
        onChanged: (enabled) ? onChanged as ValueChanged<String> : null,
      ),
    );
  }
}
