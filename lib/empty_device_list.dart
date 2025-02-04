import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyDeviceList extends StatelessWidget {
  const EmptyDeviceList({
    super.key,
    required this.localizations,
  });

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: Text(localizations.deviceListEmpty, style: Theme.of(context).textTheme.headlineSmall,)),
    );
  }
}
