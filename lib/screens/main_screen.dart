import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/presentation/tabs/bloc/tab_bloc.dart';
import 'package:flutter_basics_samples/presentation/tabs/bloc/tab_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabBloc, Tabs>(
      bloc: context.read<TabBloc>(),
      listener: (context, state) {
        if (state == Tabs.calendar) {
          _tabController.index = 0;
        } else {
          _tabController.index = 1;
        }
      },
      child: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          onTap: (index) {
            if (index == 0) {
              context.go('/calendar');
            } else {
              context.go('/admin/dashboard');
            }
          },
          tabs: [
            const Icon(Icons.calendar_month),
            const Icon(Icons.admin_panel_settings),
          ],
        ),
        body: widget.navigationShell,
      ),
    );
  }
}
