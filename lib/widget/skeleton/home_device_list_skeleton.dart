import 'package:flutter/material.dart';
import '../base/base_widget.dart';

class HomeDeviceListSkeleton extends BaseStatelessWidget {
  HomeDeviceListSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 8),
            Text(
              localizations.deviceList,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Spacer(),
            // Sort
            IconButton(onPressed: () async {}, icon: Icon(Icons.sort))
          ],
        ),
      ],
    );
  }
}
