import 'package:flutter/material.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../utilities/localization_helper.dart';

class ListDeviceType extends StatelessWidget {
  final List<AccessoryTypeEntity> accessoriesType;
  final int? deviceTypeSelected;
  final Function(int) onSelected;
  const ListDeviceType({required this.accessoriesType, this.deviceTypeSelected, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<int>(
        initialSelection:
            accessoriesType.firstWhere((e) => e.id == deviceTypeSelected, orElse: () => accessoriesType.last).id,
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
        onSelected: (int? value) {
          onSelected(value!);
        },
        leadingIcon: Icon(Icons.two_wheeler, size: 24),
        dropdownMenuEntries: accessoriesType.map<DropdownMenuEntry<int>>((AccessoryTypeEntity field) {
          return DropdownMenuEntry<int>(
            value: field.id!,
            label: field.getLocalizedName(context),
            style: ButtonStyle(textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodyMedium)),
          );
        }).toList(),
      ),
    );
  }
}
