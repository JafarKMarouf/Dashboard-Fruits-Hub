import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../features/dashboard/presentation/views/add_product/add_product_view.dart';
import '../../../../../features/dashboard/presentation/views/dashboard/dashboard_view.dart';
import '../../../../../features/orders/presentation/views/orders_view.dart';
import 'custom_bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  static const routeName = 'app-shell';

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final Set<int> _visitedTabs = {0};

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
      return;
    }

    setState(() {
      _currentIndex = index;
      _visitedTabs.add(index);
    });
  }

  Future<void> _onPopInvoked(bool didPop) async {
    if (didPop) return;
    final activeNavigator = _navigatorKeys[_currentIndex].currentState;
    if (activeNavigator != null && activeNavigator.canPop()) {
      activeNavigator.pop();
      return;
    }
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return;
    }
    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(4, (index) {
            if (!_visitedTabs.contains(index)) {
              return const SizedBox.shrink();
            }
            return Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (settings) =>
                  _onGenerateTabRoute(settings, index),
            );
          }),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _currentIndex,
          onItemTapped: _onTabTapped,
        ),
      ),
    );
  }

  Route<dynamic> _onGenerateTabRoute(RouteSettings settings, int tabIndex) {
    final Widget page = _resolveTabRoute(settings, tabIndex);
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        ),
      ),
      transitionDuration: const Duration(milliseconds: 280),
    );
  }

  Widget _resolveTabRoute(RouteSettings settings, int tabIndex) {
    switch (settings.name) {
      case AddProductView.routeName:
        return const AddProductView();
      default:
        return _tabRoot(tabIndex);
    }
  }

  Widget _tabRoot(int index) {
    switch (index) {
      case 0:
        return const DashboardView();
      case 1:
        return const Center(child: AppTextWidget('Inventory'));
      case 2:
        return const OrdersView();
      case 3:
        return const Center(child: AppTextWidget('Customers'));
      default:
        return const SizedBox.shrink();
    }
  }
}
