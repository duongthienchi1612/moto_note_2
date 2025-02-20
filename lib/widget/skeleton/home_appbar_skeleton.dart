import 'package:flutter/material.dart';
import '../base/base_widget.dart';

class HomeAppbarSkeleton extends BaseStatelessWidget {
  HomeAppbarSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        Container(
          width: 184,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(22)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.currentKm,
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
              Text(
                '',
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
