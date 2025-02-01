import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'package:moto_note_2/model/device_entity.dart';
import 'theme/app_colors.dart';
import 'widget/add_device_form.dart';
import 'widget/device_item_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final bloc = injector.get<HomeBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
            actions: [
              SizedBox(
                width: 170,
                child: Text(
                  localizations.currentKm + '12332',
                  style: textTheme.titleMedium,
                ),
              )
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _FlexibleHeaderDelegate(),
          ),
          BlocProvider(
            create: (context) => bloc..add(LoadData()),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = state.data[index];
                        return DeviceItemCard(item: item);
                      },
                      childCount: state.data.length,
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Center(
                        child: Text('Chưa có thông tin lịch sử thay thế, hay thêm mới'),
                      );
                    },
                    childCount: 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        clipBehavior: Clip.hardEdge,
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        notchMargin: 8.0,
        height: 10,
      ),
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
      color: Colors.blue,
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
