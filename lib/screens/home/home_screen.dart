import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirebase/provider/auth_provider.dart';
import 'package:myfirebase/screens/auth/login/login_screen.dart';
import 'package:myfirebase/screens/home/dashboard_screen.dart';
import 'package:myfirebase/utils/constants.dart';
import 'package:myfirebase/widgets/app_snackbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    void navigateToLogin() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    final pages = <Widget>[
      DashboardScreen(
        authState: authState,
      ),
      ...pagesList
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppSnackbar.info(
            context: context,
            message: 'Still in development',
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        iconSize: 30,
        icons: const [
          Icons.home,
          Icons.person,
        ],
        activeIndex: pageIdx,
        onTap: (index) {
          setState(() {
            pageIdx = index;
            debugPrint(pageIdx.toString());
          });
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        rightCornerRadius: 16,
        leftCornerRadius: 16,
        splashRadius: 20,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
      body: authState.when(
        data: (user) {
          return pages[pageIdx];
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, stackTrace) {
          return Center(
            child: Text('Error: $e'),
          );
        },
      ),
    );
  }
}
