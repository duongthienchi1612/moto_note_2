import 'package:flutter/material.dart';
import 'widget/base/base_widget.dart';

class EmptyDeviceList extends BaseStatelessWidget {
  EmptyDeviceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
          child: Text(
        localizations.deviceListEmpty,
        style: Theme.of(context).textTheme.headlineSmall,
      )),
    );
  }
}
