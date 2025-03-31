import 'package:flutter/material.dart';
import 'widget/base/base_widget.dart';

class EmptyDeviceList extends BaseStatelessWidget {
  const EmptyDeviceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
          child: Text(
        localizations(context).deviceListEmpty,
        style: Theme.of(context).textTheme.headlineSmall,
      )),
    );
  }
}
