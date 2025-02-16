import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'empty_device_list.dart';
import 'model/option_model.dart';
import 'theme/app_colors.dart';
import 'widget/animated_background.dart';
import 'widget/endless_background.dart';
import 'widget/base/base_widget.dart';
import 'widget/custom_bottom_appbar.dart';
import 'widget/device_item_card.dart';
import 'widget/dialog/add_device_form.dart';
import 'widget/dialog/edit_current_km_form.dart';
import 'widget/dialog/sort_form.dart';
import 'widget/home_screen_skeleton.dart';
import 'widget/side_menu.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> with TickerProviderStateMixin {
  final bloc = injector.get<HomeBloc>();

  late AnimationController _animationController;
  late Animation animation, scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(LoadData()),
      child: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return Scaffold(
                  backgroundColor: AppColors.menuBackgroundColor,
                  body: Stack(
                    children: [
                      // Side menu
                      AnimatedPositioned(
                        duration: Duration(microseconds: 200),
                        curve: Curves.fastOutSlowIn,
                        width: 288,
                        left: state.model.isMenuOpen ? 0 : -288,
                        height: MediaQuery.of(context).size.height,
                        child: SideMenu(
                          state.model.currentUser,
                          users: state.model.users,
                          onEditAccount: (value) => bloc.add(EditAccount(value)),
                          onAddAccount: (value) => bloc.add(AddAccount(value)),
                          onSwitchAccount: (value) => bloc.add(SwitchAccount(value)),
                          onDeletedAccount: (value) => bloc.add(DeleteAccount(value)),
                        ),
                      ),

                      // Main Content
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(animation.value - 30 * animation.value * pi / 180),
                        child: Transform.translate(
                          offset: Offset(animation.value * 288, 0),
                          child: Transform.scale(
                            scale: scaleAnimation.value,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                              child: GestureDetector(
                                onTap: () {
                                  if (state.model.isMenuOpen) {
                                    _animationController.reverse();
                                    bloc.add(OpenMenu(false));
                                  }
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Stack(
                                    children: [
                                      AnimatedWaveBackground(),
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            // App bar
                                            SizedBox(height: MediaQuery.of(context).padding.top),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (!state.model.isMenuOpen) {
                                                      _animationController.forward();
                                                    } else {
                                                      _animationController.reverse();
                                                    }
                                                    bloc.add(OpenMenu(!state.model.isMenuOpen));
                                                  },
                                                  icon: Icon(
                                                    Icons.menu,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final value = await showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return EditCurrentKmForm(currentKm: state.model.currentKm);
                                                      },
                                                    );
                                                    if (value != null) {
                                                      bloc.add(UpdateCurrentKm(value));
                                                    }
                                                  },
                                                  child: Container(
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
                                                          style: theme.textTheme.titleMedium!
                                                              .copyWith(color: Colors.white),
                                                        ),
                                                        TweenAnimationBuilder(
                                                          tween: IntTween(begin: 0, end: state.model.currentKm),
                                                          curve: Curves.easeInOutCirc,
                                                          duration: Duration(milliseconds: 600),
                                                          builder: (context, value, child) {
                                                            return Text(
                                                              ' $value',
                                                              style: theme.textTheme.titleMedium!
                                                                  .copyWith(color: Colors.white),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                            // Background animation
                                            // IgnorePointer(
                                            //   ignoring: state.model.isMenuOpen,
                                            //   child: SizedBox(
                                            //     height: 220,
                                            //     child: GameWidget(
                                            //       game: EndlessBackground(),
                                            //     ),
                                            //   ),
                                            // ),
                                            const SizedBox(
                                              height: 220,
                                            ),

                                            // Device list
                                            Row(
                                              children: [
                                                SizedBox(width: 8),
                                                Text(
                                                  localizations.deviceList,
                                                  style: theme.textTheme.headlineSmall,
                                                ),
                                                Spacer(),
                                                // Sort
                                                IconButton(
                                                    onPressed: () async {
                                                      final value = await showDialog<OptionModel>(
                                                        context: context,
                                                        builder: (_) {
                                                          return SortForm();
                                                        },
                                                      );
                                                      if (value != null) {
                                                        bloc.add(SortData(value));
                                                      }
                                                    },
                                                    icon: Icon(Icons.sort))
                                              ],
                                            ),
                                            if (state.model.data.isNotEmpty) ...[
                                              IgnorePointer(
                                                ignoring: state.model.isMenuOpen,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: state.model.data.length,
                                                  itemBuilder: (ctx, index) {
                                                    return DeviceItemCard(
                                                      item: state.model.data[index],
                                                      currentKm: state.model.currentKm,
                                                      deletedItem: (item) => bloc.add(DeleteItem(item.id!)),
                                                      onChanged: () => bloc.add(LoadData()),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 48),
                                            ] else
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 120),
                                                  child: Text(
                                                    localizations.deviceListEmpty,
                                                    style: theme.textTheme.headlineSmall,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  floatingActionButton: Visibility(
                    visible: !state.model.isMenuOpen,
                    child: Transform.translate(
                      offset: Offset(0, 4),
                      child: FloatingActionButton(
                        shape: CircleBorder(),
                        mini: true,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (_) {
                              return AddDeviceForm(isAddNew: true);
                            },
                          );
                          bloc.add(LoadData());
                        },
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.add, size: 30),
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                );
              }
              return HomeScreenSkeleton();
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 48,
            right: 0,
            left: 0,
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previus, current) {
                if (previus is HomeInitial) {
                  return true;
                }
                if (previus is HomeLoaded && current is HomeLoaded) {
                  if (previus.model.isMenuOpen != current.model.isMenuOpen) {
                    return true;
                  }
                }
                return false;
              },
              builder: (context, state) {
                if (state is HomeLoaded && state.model.isMenuOpen == false) {
                  return Transform.translate(
                    offset: Offset(animation.value * 288, 0),
                    child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: SizedBox(
                        height: 220,
                        child: GameWidget(
                          game: EndlessBackground(),
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
