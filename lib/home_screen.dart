import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'empty_device_list.dart';
import 'model/option_model.dart';
import 'theme/app_colors.dart';
import 'utilities/string_formatter.dart';
import 'widget/animated_background.dart';
import 'widget/base/base_widget.dart';
import 'widget/custom_bottom_appbar.dart';
import 'widget/device_item_card.dart';
import 'widget/dialog/add_device_form.dart';
import 'widget/dialog/edit_current_km_form.dart';
import 'widget/dialog/sort_form.dart';
import 'widget/side_menu.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> with SingleTickerProviderStateMixin {
  final bloc = injector.get<HomeBloc>();

  late AnimationController _animationController;
  late Animation animation, scaleAnimation, listAppearAnimation;

  bool isMenuOpen = false;

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
    listAppearAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => bloc..add(LoadData()),
      child: BlocBuilder<HomeBloc, HomeState>(
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
                    left: isMenuOpen ? 0 : -288,
                    height: MediaQuery.of(context).size.height,
                    child: SideMenu(
                      state.model.currentUser,
                      users: state.model.users,
                      onEditAccount: (value) => bloc.add(EditAccount(value)),
                      onAddAccount: (value) => bloc.add(AddAccount(value)),
                      onSwitchAccount: (value) => bloc.add(SwitchAccount(value)),
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
                          child: Container(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                AnimatedWaveBackground(),
                                CustomScrollView(
                                  slivers: <Widget>[
                                    SliverAppBar(
                                      floating: true,
                                      surfaceTintColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      actions: [
                                        GestureDetector(
                                          onTap: () async {
                                            final value = await showDialog(
                                              context: context,
                                              builder: (_) {
                                                return EditCurrentKmForm(currentKm: state.model.currentKm);
                                              },
                                            );
                                            if (value != null) {
                                              await bloc.updateCurrentKm(value);
                                            }
                                          },
                                          child: Container(
                                            width: 184,
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.symmetric(horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.black, borderRadius: BorderRadius.circular(22)),
                                            child: Text(
                                              '${localizations.currentKm} ${StringFormatter.formatDisplayKm(state.model.currentKm.toString())}',
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: textTheme.titleMedium!.copyWith(color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _FlexibleHeaderDelegate(
                                        (value) {
                                          bloc.add(SortData(filter: value, localizations: localizations));
                                        },
                                        currentKm: state.model.currentKm.toString(),
                                      ),
                                    ),
                                    if (state.model.data.isNotEmpty) ...[
                                      SliverAnimatedOpacity(
                                        duration: Duration(microseconds: 600),
                                        opacity: listAppearAnimation.value,
                                        curve: Curves.easeInOut,
                                        sliver: SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) => DeviceItemCard(
                                              item: state.model.data[index],
                                              currentKm: state.model.currentKm,
                                              deletedItem: (item) => bloc.add(DeleteItem(item.id!)),
                                              onChanged: () => bloc.add(LoadData()),
                                            ),
                                            childCount: state.model.data.length,
                                          ),
                                        ),
                                      ),
                                      SliverToBoxAdapter(child: SizedBox(height: 60)),
                                    ] else
                                      EmptyDeviceList()
                                  ],
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: CustomBottomAppBar(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(microseconds: 200),
                    curve: Curves.fastOutSlowIn,
                    top: 0,
                    left: isMenuOpen ? 260 : 16,
                    child: SafeArea(
                      child: CircleAvatar(
                        backgroundColor: isMenuOpen ? Colors.white : Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            if (isMenuOpen == false) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                            setState(() {
                              isMenuOpen = !isMenuOpen;
                            });
                          },
                          icon: Icon(
                            isMenuOpen ? Icons.close : Icons.menu,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: Visibility(
                visible: !isMenuOpen,
                child: Transform.translate(
                  offset: Offset(0, 10),
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
          return Stack(
            children: [
              Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    AnimatedWaveBackground(),
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          floating: true,
                          surfaceTintColor: Colors.white,
                          backgroundColor: Colors.white,
                          actions: [
                            Container(
                              width: 184,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(22)),
                              child: Text(
                                '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: textTheme.titleMedium!.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _FlexibleHeaderDelegate(
                            (value) {
                              bloc.add(SortData(filter: value, localizations: localizations));
                            },
                            currentKm: '',
                          ),
                        ),
                      ],
                    ),
                    Positioned(bottom: 0, right: 0, left: 0, child: CustomBottomAppBar()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FlexibleHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String? currentKm;
  final Function(OptionModel) onFilter;

  _FlexibleHeaderDelegate(this.onFilter, {this.currentKm});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final localizations = AppLocalizations.of(context)!;
    final progress = (maxExtent - shrinkOffset) / maxExtent;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: progress > 0.9,
            child: Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImagePath.contermet))),
                  ),
                  Text(
                    currentKm ?? '',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                localizations.deviceList,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Spacer(),
              // Sort
              IconButton(
                  onPressed: () async {
                    final value = await showDialog<OptionModel>(
                      context: context,
                      builder: (_) {
                        return SortForm(
                          localizations: localizations,
                        );
                      },
                    );
                    if (value != null) {
                      onFilter(value);
                    }
                  },
                  icon: Icon(Icons.sort))
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 280;
  @override
  double get minExtent => 100;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
