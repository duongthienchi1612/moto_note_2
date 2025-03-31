import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../bloc/cubit/device_item_cubit.dart';
import '../constants.dart';
import '../dependencies.dart';
import '../model/device_entity.dart';
import '../utilities/colors_utility.dart';
import '../utilities/string_formatter.dart';
import 'base/base_widget.dart';
import 'dialog/add_device_form.dart';

class DeviceItemCard extends StatefulWidget {
  final DeviceEntity item;
  final int currentKm;
  final Function(DeviceEntity) deletedItem;
  final Function() onChanged;

  const DeviceItemCard(
      {Key? key, required this.item, required this.deletedItem, required this.currentKm, required this.onChanged})
      : super(key: key);

  @override
  State<DeviceItemCard> createState() => _DeviceItemCardState();
}

class _DeviceItemCardState extends BaseState<DeviceItemCard> {
  final cubit = injector.get<DeviceItemCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<DeviceItemCubit, DeviceItemState>(
        builder: (context, state) {
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              cubit.updateDx(details.primaryDelta! + cubit.state.dx);
            },
            onHorizontalDragEnd: (_) {
              if (state.dx > Constants.offsetShowIconDeleted) {
                cubit.resetDx();
              }
            },
            // Edit device
            onTap: () async {
              await showDialog(
                context: context,
                builder: (_) {
                  return AddDeviceForm(deviceId: widget.item.id);
                },
              );
              widget.onChanged();
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                // Nút xóa
                AnimatedContainer(
                  height: 72,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  duration: Duration(milliseconds: 180),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      iconSize: 24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                      side: BorderSide(color: Colors.transparent),
                      backgroundColor: Colors.red,
                    ),
                    child: Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      cubit.resetDx();
                      _showDeleteConfirmation();
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  transform: Matrix4.translationValues(state.dx, 0, 0),
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(state.dx == Constants.offsetShowIconDeleted ? 48 : 20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Tính toán tỷ lệ cho phù hợp với kích thước màn hình
                      final screenWidth = MediaQuery.of(context).size.width;
                      final isSmallScreen = screenWidth < 360;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.item.deviceName ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: isSmallScreen ? 16 : null,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text(
                                            widget.item.lastReplacementDate != null
                                                ? DateFormat('dd-MM-yyyy').format(widget.item.lastReplacementDate!)
                                                : '',
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey.shade700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (widget.item.lastReplacementDate != null &&
                                              widget.item.lastReplacementKm != null)
                                            Icon(
                                              Icons.fiber_manual_record,
                                              color: Colors.grey,
                                              size: 8,
                                            ),
                                          Icon(
                                            Icons.speed,
                                            size: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                          Text(
                                            widget.item.lastReplacementKm != null
                                                ? StringFormatter.formatDisplayKm(widget.item.lastReplacementKm.toString()) +
                                                    ' Km'
                                                : '',
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey.shade700,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: isSmallScreen ? 8 : 12),
                              constraints: BoxConstraints(
                                minWidth: isSmallScreen ? 70 : 80,
                                maxWidth: isSmallScreen ? 85 : 100,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                                  color: ColorsUtility.getStatusColor(widget.item.nextReplacementKm, widget.currentKm),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsUtility.getStatusColor(widget.item.nextReplacementKm, widget.currentKm)
                                          .withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ]),
                              child: Text(
                                widget.item.nextReplacementKm != null
                                    ? StringFormatter.formatDisplayKm(widget.item.nextReplacementKm.toString()) + ' Km'
                                    : 'N/A',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: isSmallScreen ? 11 : 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation() {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            localizations.deleteDevice,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Text(
            '${localizations.deleteDeviceConfirmation} "${widget.item.deviceName}"?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                localizations.cancel,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.deletedItem(widget.item);
              },
              child: Text(
                localizations.delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
