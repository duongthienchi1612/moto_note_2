import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // double dx = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<DeviceItemCubit, DeviceItemState>(
        builder: (context, state) {
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              cubit.updateDx(details.primaryDelta! + cubit.state.dx);

              // setState(() {
              //   dx = details.primaryDelta! + dx;
              //   if (dx < Constants.offsetShowIconDeleted) {
              //     dx = Constants.offsetShowIconDeleted;
              //   }
              //   if (dx > 0) {
              //     dx = 0;
              //   }
              // });
            },
            onHorizontalDragEnd: (_) {
              // if (dx > Constants.offsetShowIconDeleted) {
              //   setState(() => dx = 0);
              // }
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
                      // setState(() {
                      //   dx = 0;
                      // });
                      cubit.resetDx();
                      widget.deletedItem(widget.item);
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 180),
                  transform: Matrix4.translationValues(state.dx, 0, 0),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(state.dx == Constants.offsetShowIconDeleted ? 48 : 32),
                  ),
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.item.deviceName ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineSmall,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.item.lastReplacementDate != null
                                      ? DateFormat('dd-MM-yyyy').format(widget.item.lastReplacementDate!)
                                      : '',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                if (widget.item.lastReplacementDate != null &&
                                    widget.item.lastReplacementKm != null) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(
                                      Icons.fiber_manual_record,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  )
                                ],
                                Text(
                                  widget.item.lastReplacementKm != null
                                      ? StringFormatter.formatDisplayKm(widget.item.lastReplacementKm.toString()) +
                                          ' Km'
                                      : '',
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Constants.borderRadius),
                            color: ColorsUtility.getStatusColor(widget.item.nextReplacementKm, widget.currentKm)),
                        child: Text(
                          widget.item.nextReplacementKm != null
                              ? StringFormatter.formatDisplayKm(widget.item.nextReplacementKm.toString()) + ' Km'
                              : 'N/A',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
