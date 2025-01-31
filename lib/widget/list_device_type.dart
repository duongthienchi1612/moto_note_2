import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../theme/app_colors.dart';

class ListDeviceType extends StatelessWidget {
  final List<AccessoryTypeEntity> accessoriesType;
  final int? deviceTypeSelected;
  final Function(int) onSelected;
  const ListDeviceType({required this.accessoriesType, this.deviceTypeSelected, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...accessoriesType
                  .take(4)
                  .map(
                    (e) => AnimatedContainer(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.only(right: 8, bottom: 8),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: deviceTypeSelected == e.id ? AppColors.devicesType[e.id]! : Colors.white,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        border: Border.all(
                          color: deviceTypeSelected == e.id ? Colors.black : Colors.grey,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            textStyle: deviceTypeSelected == e.id ? textTheme.titleLarge : textTheme.bodyLarge),
                        onPressed: () => onSelected(e.id!),
                        child: Text(e.nameVi!),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          Row(
            children: [
              ...accessoriesType
                  .skip(4)
                  .map(
                    (e) => AnimatedContainer(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      margin: EdgeInsets.only(right: 8),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: deviceTypeSelected == e.id ? AppColors.devicesType[e.id]! : Colors.white,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        border: Border.all(
                          color: deviceTypeSelected == e.id ? Colors.black : Colors.grey,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            textStyle: deviceTypeSelected == e.id ? textTheme.titleLarge : textTheme.bodyLarge),
                        onPressed: () => onSelected(e.id!),
                        child: Text(e.nameVi!),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
