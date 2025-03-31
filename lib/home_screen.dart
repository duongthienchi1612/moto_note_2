import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'dependencies.dart';
import 'model/option_model.dart';
import 'preference/user_reference.dart';
import 'theme/app_colors.dart';
import 'widget/animated_background.dart';
import 'widget/base/base_widget.dart';
import 'widget/device_item_card.dart';
import 'widget/dialog/add_device_form.dart';
import 'widget/dialog/edit_current_km_form.dart';
import 'widget/dialog/sort_form.dart';
import 'widget/endless_background.dart';
import 'widget/side_menu.dart';
import 'widget/skeleton/home_appbar_skeleton.dart';
import 'widget/skeleton/home_device_list_skeleton.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> with TickerProviderStateMixin {
  final bloc = injector.get<HomeBloc>();
  final _userReference = injector.get<UserReference>();

  late final Widget _gameWidget;

  late AnimationController _animationController;
  late Animation animation, scaleAnimation;

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
    bloc.add(LoadData());

    _gameWidget = SizedBox(
      height: 220,
      child: GameWidget(game: EndlessBackground()),
    );
  }

  // Hàm xử lý khi thay đổi ngôn ngữ
  void _handleLanguageChange(String languageCode) {
    // Lưu ngôn ngữ vào SharedPreferences
    _userReference.setLanguage(languageCode);
    // Gọi callback để thay đổi ngôn ngữ
    widget.changeLanguage(languageCode);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
          backgroundColor: AppColors.menuBackgroundColor,
          body: Stack(
            children: [
              // Side menu
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return AnimatedPositioned(
                      duration: Duration(microseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      width: 288,
                      left: isMenuOpen ? 0 : -288,
                      height: MediaQuery.of(context).size.height,
                      child: SideMenu(
                        state.model.currentUser,
                        users: state.model.users,
                        onEditAccount: (userId, value) => bloc.add(EditAccount(userId, value)),
                        onAddAccount: (value) => bloc.add(AddAccount(value)),
                        onSwitchAccount: (value) => bloc.add(SwitchAccount(value)),
                        onDeletedAccount: (value) => bloc.add(DeleteAccount(value)),
                        changeLanguage: _handleLanguageChange,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
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
                      borderRadius: BorderRadius.all(Radius.circular(isMenuOpen ? 22 : 0)),
                      child: GestureDetector(
                        onTap: () {
                          if (isMenuOpen) {
                            _animationController.reverse();
                            setState(() {
                              isMenuOpen = false;
                            });
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              AnimatedWaveBackground(),
                              SafeArea(
                                child: Column(
                                  children: [
                                    // App bar
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state is HomeLoaded) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (!isMenuOpen) {
                                                      _animationController.forward();
                                                    } else {
                                                      _animationController.reverse();
                                                    }
                                                    setState(() {
                                                      isMenuOpen = !isMenuOpen;
                                                    });
                                                  },
                                                  icon: AnimatedIcon(
                                                    icon: AnimatedIcons.menu_close,
                                                    progress: _animationController,
                                                    color: Colors.black87,
                                                    size: 28,
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
                                                  child: LayoutBuilder(builder: (context, constraints) {
                                                    final screenWidth = MediaQuery.of(context).size.width;
                                                    final isSmallScreen = screenWidth < 360;
                                                    
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: isSmallScreen ? 8 : 10,
                                                        horizontal: isSmallScreen ? 12 : 16
                                                      ),
                                                      constraints: BoxConstraints(
                                                        minWidth: isSmallScreen ? 120 : 150,
                                                        maxWidth: MediaQuery.of(context).size.width * 0.5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [Colors.blue.shade800, Colors.blue.shade600],
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                        ),
                                                        borderRadius: BorderRadius.circular(22),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.blue.shade300.withOpacity(0.4),
                                                            blurRadius: 10,
                                                            offset: Offset(0, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            isSmallScreen ? 'Km:' : localizations.currentKm,
                                                            style: theme.textTheme.titleMedium!.copyWith(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: isSmallScreen ? 13 : null,
                                                            ),
                                                          ),
                                                          SizedBox(width: 4),
                                                          TweenAnimationBuilder(
                                                            tween: IntTween(begin: 0, end: state.model.currentKm),
                                                            curve: Curves.easeInOutCirc,
                                                            duration: Duration(milliseconds: 600),
                                                            builder: (context, value, child) {
                                                              return Text(
                                                                '$value',
                                                                style: theme.textTheme.titleMedium!.copyWith(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: isSmallScreen ? 13 : null,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return HomeAppbarSkeleton();
                                        }
                                      },
                                    ),

                                    Expanded(
                                      child: ListView(
                                        physics: BouncingScrollPhysics(),
                                        children: [
                                          // Animation
                                          IgnorePointer(
                                            ignoring: isMenuOpen,
                                            child: _gameWidget,
                                          ),

                                          // Device list
                                          BlocBuilder<HomeBloc, HomeState>(builder: (ctx, state) {
                                            if (state is HomeLoaded) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          localizations.deviceList,
                                                          style: theme.textTheme.headlineSmall!.copyWith(
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        // Sort
                                                        Material(
                                                          color: Colors.grey.shade200,
                                                          borderRadius: BorderRadius.circular(12),
                                                          child: InkWell(
                                                            borderRadius: BorderRadius.circular(12),
                                                            onTap: () async {
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
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child: Icon(Icons.sort, color: Colors.grey.shade700),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  if (state.model.data.isNotEmpty) ...[
                                                    IgnorePointer(
                                                      ignoring: isMenuOpen,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
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
                                                    SizedBox(height: 80),
                                                  ] else
                                                    Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 80),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              localizations.deviceListEmpty,
                                                              style: theme.textTheme.titleLarge!.copyWith(
                                                                color: Colors.grey.shade600,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                            SizedBox(height: 16),
                                                            Text(
                                                              localizations.tapToAddNewDevice,
                                                              textAlign: TextAlign.center,
                                                              style: theme.textTheme.bodyMedium!.copyWith(
                                                                color: Colors.grey.shade500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }
                                            return HomeDeviceListSkeleton();
                                          })
                                        ],
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
          floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoaded) {
                return Visibility(
                  visible: !isMenuOpen,
                  child: Transform.translate(
                    offset: Offset(0, 4),
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (_) {
                            return AddDeviceForm(isAddNew: true);
                          },
                        );
                        bloc.add(LoadData());
                      },
                      backgroundColor: Colors.blue.shade600,
                      child: const Icon(Icons.add, size: 30),
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ));
  }
}
