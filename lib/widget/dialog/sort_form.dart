import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/option_model.dart';
import '../base/base_widget.dart';

class SortForm extends StatefulWidget {
  const SortForm({
    super.key,
  });

  @override
  State<SortForm> createState() => _SortFormState();
}

class _SortFormState extends BaseState<SortForm> {
  late List<OptionModel> fields, options;

  late String fieldValue, optionValue;

  @override
  void initState() {
    super.initState();

    fields = [
      OptionModel(localizations.fieldName, SortField.name),
      OptionModel(localizations.fieldLastReplacementKm, SortField.lastKm),
      OptionModel(localizations.fieldLastReplacementDate, SortField.lastDate),
      OptionModel(localizations.fieldNextReplacementKm, SortField.nextKm),
    ];
    options = [
      OptionModel(localizations.sortLowToHigh, SortField.aZ),
      OptionModel(localizations.sortHighToLow, SortField.Za),
    ];

    fieldValue = fields.first.value;
    optionValue = options.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.sortDeviceFormTitle,
                  style: theme.textTheme.headlineMedium,
                ),
                Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DropdownMenu<String>(
                initialSelection: fieldValue,
                expandedInsets: EdgeInsets.all(0),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                menuStyle: MenuStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    alignment: AlignmentDirectional.bottomStart,
                    visualDensity: VisualDensity(vertical: 2.0),
                    elevation: WidgetStatePropertyAll(6)),
                onSelected: (String? value) {
                  setState(() {
                    fieldValue = value!;
                  });
                },
                leadingIcon: Icon(Icons.text_fields, size: 24),
                dropdownMenuEntries: fields.map<DropdownMenuEntry<String>>((OptionModel field) {
                  return DropdownMenuEntry<String>(
                    value: field.value,
                    label: field.name,
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(theme.textTheme.bodyMedium)
                    )
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: DropdownMenu<String>(
                initialSelection: optionValue,
                expandedInsets: EdgeInsets.all(0),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                menuStyle: MenuStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    alignment: AlignmentDirectional.bottomStart,
                    visualDensity: VisualDensity(vertical: 2.0),
                    elevation: WidgetStatePropertyAll(6)),
                onSelected: (String? value) {
                  setState(() {
                    optionValue = value!;
                  });
                },
                leadingIcon: Icon(Icons.sort_by_alpha, size: 24),
                dropdownMenuEntries: options.map<DropdownMenuEntry<String>>((OptionModel field) {
                  return DropdownMenuEntry<String>(
                    value: field.value,
                    label: field.name,
                    style: ButtonStyle(textStyle: WidgetStatePropertyAll(theme.textTheme.bodyMedium)),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 24),
            OutlinedButton(
              onPressed: () async {
                final OptionModel model = OptionModel(fieldValue, optionValue);
                Navigator.pop(context, model);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.transparent),
              ),
              child: Center(
                child: Text(localizations.sortDeviceCompletedButton,
                    style: theme.textTheme.titleLarge!.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
