import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../dependencies.dart';
import '../../preference/user_reference.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({super.key});
  AppLocalizations localizations(BuildContext context) => AppLocalizations.of(context)!;
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  AppLocalizations get localizations => AppLocalizations.of(context)!;
  final userRef = injector.get<UserReference>();
  ThemeData get theme => Theme.of(context);
}
