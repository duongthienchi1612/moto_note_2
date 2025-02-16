import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'animated_background.dart';
import 'base/base_widget.dart';

class HomeScreenSkeleton extends BaseStatelessWidget {
  HomeScreenSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Stack(
            children: [
              AnimatedWaveBackground(),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.black),
                      ),
                      Container(
                        width: 184,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration:
                            BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localizations.currentKm,
                              style: textTheme.titleMedium!.copyWith(color: Colors.white),
                            ),
                            TweenAnimationBuilder(
                              tween: IntTween(begin: 0, end: 0),
                              curve: Curves.easeInOutCirc,
                              duration: Duration(milliseconds: 600),
                              builder: (context, value, child) {
                                return Text(
                                  ' $value',
                                  style: textTheme.titleMedium!.copyWith(color: Colors.white),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 220,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        localizations.deviceList,
                        style: textTheme.headlineSmall,
                      ),
                      Spacer(),
                      // Sort
                      IconButton(onPressed: () async {}, icon: Icon(Icons.sort))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
