import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'dependencies.dart';
import 'empty_device_list.dart';
import 'utilities/string_formatter.dart';
import 'widget/add_device_form.dart';
import 'widget/animated_background.dart';
import 'widget/custom_bottom_appbar.dart';
import 'widget/device_item_card.dart';
import 'widget/edit_current_km_form.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final bloc = injector.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedWaveBackground(),
          BlocProvider(
            create: (context) => bloc..add(LoadData()),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () async {
                              final value = await showDialog(
                                context: context,
                                builder: (_) {
                                  return EditCurrentKmForm(currentKm: state.currentKm);
                                },
                              );
                              await bloc.updateCurrentKm(value);
                            },
                            child: Container(
                              width: 184,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(color: Colors.black,
                                borderRadius: BorderRadius.circular(22)
                              ),
                              child: Text(
                                '${localizations.currentKm} ${StringFormatter.formatDisplayKm(state.currentKm.toString())}',
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
                        delegate: _FlexibleHeaderDelegate(),
                      ),
                      if (state.data.isNotEmpty)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => DeviceItemCard(
                              item: state.data[index],
                              currentKm: state.currentKm,
                              deletedItem: (item) => bloc.add(DeleteItem(item.id!)),
                            ),
                            childCount: state.data.length,
                          ),
                        )
                      else
                        EmptyDeviceList(localizations: localizations)
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        mini: true,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) {
              return AddDeviceForm();
            },
          );
          bloc.add(LoadData());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

class _FlexibleHeaderDelegate extends SliverPersistentHeaderDelegate {
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
          Opacity(
            opacity: progress,
            child: Visibility(
              visible: progress > 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Nội dung mở rộng khi maxExtent",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.list),
              SizedBox(
                width: 8,
              ),
              Text(
                localizations.deviceList,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;
  @override
  double get minExtent => 100;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
