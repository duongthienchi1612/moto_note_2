import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../model/device_entity.dart'; // Ensure correct import path

class DeviceItemCard extends StatelessWidget {
  final DeviceEntity item;

  const DeviceItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
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
                  item.deviceName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall,
                ),
                Row(
                  children: [
                    Text(
                      item.lastReplacementDate != null ? DateFormat('dd-MM-yyyy').format(item.lastReplacementDate!) : '',
                      style: textTheme.bodyLarge,
                    ),
                    if (item.lastReplacementDate != null && item.lastReplacementKm != null) ...[
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
                      item.lastReplacementKm.toString() + ' Km',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Constants.borderRadius), color: Colors.green),
            child: Text(
              item.nextReplacementKm.toString() + ' Km',
              style: textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
