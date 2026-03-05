import 'package:flutter/material.dart';

import '../../../../features/dashboard/presentation/views/dashboard_view.dart';
import 'custom_bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  static const routeName = 'app-shell';

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  final List<Widget> _tabRoots = const [
    DashboardView(),
    Center(child: Text('Inventory')),
    Center(child: Text('Orders')),
    Center(child: Text('Reports')),
  ];
  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  Future<bool> _onWillPop() async {
    final activeNavigator = _navigatorKeys[_currentIndex].currentState;
    if (activeNavigator != null && activeNavigator.canPop()) {
      activeNavigator.pop();
      return false;
    }
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => _onWillPop(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(
            _tabRoots.length,
            (index) => Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (settings) =>
                  _onGenerateTabRoute(settings, index),
            ),
          ),
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
      pageBuilder: (_, animation, _) => page,
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
      // case AddProductView.routeName:
      //   return const AddProductView();

      // ── Tab 1: Inventory sub-routes ──────────────────────────────────────
      // case ProductDetailView.routeName:
      //   final product = settings.arguments as ProductEntity;
      //   return ProductDetailView(product: product);

      // ── Tab 2: Orders sub-routes ─────────────────────────────────────────
      // case OrderDetailView.routeName:
      //   return const OrderDetailView();

      // Fallthrough → show the tab's root widget
      default:
        return _tabRoots[tabIndex];
    }
  }
}
