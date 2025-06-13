import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc_event.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_state.dart';
import 'package:flutter_basics_samples/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();

    final router = GoRouter.of(context);
    router.routerDelegate.addListener(() {
      _updateTab(router.routerDelegate.currentConfiguration.fullPath);
    });

    final path = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    _updateTab(path);
  }

  void _updateTab(String path) {
    final shellRoute = router.routerDelegate.currentConfiguration.fullPath;
    if (shellRoute == '/admin/dashboard') {
      context.read<AdminBloc>().add(AdminStateChangedEvent(tab: AdminTabs.dashboard));
    } else if (shellRoute == '/admin/establishment') {
      context.read<AdminBloc>().add(AdminStateChangedEvent(tab: AdminTabs.establishment));
    } else if (shellRoute == '/admin/employees') {
      context.read<AdminBloc>().add(AdminStateChangedEvent(tab: AdminTabs.employees));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                final selectedTab = state.tab;

                return Column(
                  children: [
                    FilledButton(
                      onPressed: () => context.go('/admin/dashboard'),
                      style: FilledButton.styleFrom(
                        backgroundColor: selectedTab == AdminTabs.dashboard ? Colors.blue : null,
                      ),
                      child: Text('Dashboard'),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () => context.go('/admin/establishment'),
                      style: FilledButton.styleFrom(
                        backgroundColor: selectedTab == AdminTabs.establishment ? Colors.blue : null,
                      ),
                      child: Text('Establishment'),
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () => context.go('/admin/employees'),
                      style: FilledButton.styleFrom(
                        backgroundColor: selectedTab == AdminTabs.employees ? Colors.blue : null,
                      ),
                      child: Text('Employees'),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(child: widget.navigationShell),
        ],
      ),
    );
  }
}
