import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants.dart';

class InputDeviceName extends StatelessWidget {
  const InputDeviceName({
    super.key,
    required this.localizations,
    required this.accessories,
    required this.onChanged,
    required this.onSelected,
  });

  final AppLocalizations localizations;
  final List<String> accessories;
  final Function(String) onChanged;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.deviceName, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8),
        LayoutBuilder(builder: (ctx, constraints) {
          return Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              final input = removeDiacritics(textEditingValue.text.toLowerCase());
              return accessories.where(
                (String option) {
                  return removeDiacritics(option.toLowerCase()).contains(input);
                },
              );
            },
            onSelected: onSelected,
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadius)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadius)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: onChanged,
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.borderRadius),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    elevation: 4.0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 200,
                        maxWidth: constraints.biggest.width,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = options.elementAt(index);
                          return InkWell(
                            onTap: () {
                              onSelected(option);
                            },
                            child: Builder(builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(option),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
