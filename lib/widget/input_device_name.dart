import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/master_data/accessory_entity.dart';
import '../utilities/localization_helper.dart';
import 'base/base_widget.dart';

class InputDeviceName extends StatefulWidget {
  const InputDeviceName({
    super.key,
    required this.accessories,
    required this.onChanged,
    required this.onSelected,
    this.deviceName,
  });
  final String? deviceName;
  final List<AccessoryEntity> accessories;
  final Function(String) onChanged;
  final Function(dynamic) onSelected;

  @override
  State<InputDeviceName> createState() => _InputDeviceNameState();
}

class _InputDeviceNameState extends BaseState<InputDeviceName> {
  late TextEditingController _controller;
  late List<String> _localizedAccessoryNames;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.deviceName ?? '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cập nhật danh sách tên theo ngôn ngữ hiện tại
    _localizedAccessoryNames = widget.accessories
        .map((accessory) => accessory.getLocalizedName(context))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.deviceName, style: theme.textTheme.titleLarge),
        SizedBox(height: 8),
        LayoutBuilder(builder: (ctx, constraints) {
          return Autocomplete<String>(
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              final input = removeDiacritics(textEditingValue.text.toLowerCase());
              return _localizedAccessoryNames.where(
                (String option) {
                  return removeDiacritics(option.toLowerCase()).contains(input);
                },
              );
            },
            onSelected: (String selectedValue) {
                setState(() {
                  _controller.text = selectedValue;
                });
                widget.onSelected(selectedValue);
              },
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              textEditingController.text = _controller.text;
                textEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: textEditingController.text.length),
                );
              return TextFormField(
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
                  onChanged: (value) {
                    _controller.text = value;
                    widget.onChanged(value);
                  });
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
