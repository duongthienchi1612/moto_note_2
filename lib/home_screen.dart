import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc.dart';
import 'dependencies.dart';
import 'preference/user_reference.dart';
import 'theme/app_colors.dart';
import 'widget/add_device_form.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) changeLanguage;
  const HomeScreen({Key? key, required this.changeLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/images/motobike.png'),
            ),
          ),
          BlocProvider(
            create: (context) => HomeBloc()..add(LoadData()),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = state.data[index];
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey)), color: Colors.white),
                          height: 100.0,
                          child: Text(
                            item.deviceName ?? '',
                            style: textTheme.bodyLarge,
                          ),
                        );
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
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AddDeviceForm();
              });
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
