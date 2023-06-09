import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/screens/screens.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _BottomNavigation(),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      onTap: (value) {
        navigationModel.paginaActual = value;
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Interest',
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: 'Topics',
          icon: Icon(Icons.public),
        )
      ],
      currentIndex: navigationModel.paginaActual,
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationProvider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Screen(), Tab2Screen()],
    );
  }
}

class _NavigationModel extends ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int value) {
    _paginaActual = value;
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );

    notifyListeners();
  }

  PageController get pageController => _pageController;
}
