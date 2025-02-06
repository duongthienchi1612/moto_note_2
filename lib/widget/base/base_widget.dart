import 'package:flutter/material.dart';

import '../../utilities/localization_helper.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  BaseStatelessWidget({super.key});
  final localizations = LocalizationHelper.instance;
}

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final localizations = LocalizationHelper.instance;
}
