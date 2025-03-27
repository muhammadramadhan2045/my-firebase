import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirebase/provider/auth_provider.dart';
import 'package:myfirebase/provider/profile_provider.dart';
import 'package:myfirebase/screens/auth/login/login_screen.dart';
import 'package:myfirebase/widgets/adapter/transaction_adapter.dart';
import 'package:myfirebase/widgets/custom_box_container.dart';
import 'package:myfirebase/widgets/custom_header.dart';
import 'package:myfirebase/widgets/item/item_menu.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({
    super.key,
    required this.authState,
  });

  final AsyncValue<User?> authState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilState = ref.watch(profileProvider);
    return profilState.when(
      data: (profilData) {
        return widget.authState.when(
          data: (user) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomHeader(
                      username: profilData?.username ?? '',
                      pressLogout: () {
                        ref.read(authProvider.notifier).logout();
                        navigateToLogin();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      margin: EdgeInsets.only(
                        top: 0.8.dp,
                        left: 4.w,
                        right: 4.w,
                        bottom: 5.5.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Menu',
                                style: TextStyle(
                                  fontSize: 16.sp, 
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.dashboard,
                                size: 5.w, 
                              ),
                            ],
                          ),
                          GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: 1,
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            children: [
                              ItemMenu(
                                menuName: 'Pelanggan',
                                menuIcon: Icons.people,
                              ),
                              ItemMenu(
                                menuName: 'Profile',
                                menuIcon: Icons.person,
                              ),
                              ItemMenu(
                                menuName: 'Pengaduan',
                                menuIcon: Icons.comment,
                              ),
                              ItemMenu(
                                menuName: 'Tagihan',
                                menuIcon: Icons.money_rounded,
                              ),
                              ItemMenu(
                                menuName: 'Settings',
                                menuIcon: Icons.settings,
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomBoxContainer(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Last Transaction',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(
                                      Icons.history,
                                      size: 5.w,
                                    ),
                                  ],
                                ),
                                TransactionAdapter(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stacktrace) {
            return Center(
              child: Text(
                error.toString(),
                style: TextStyle(fontSize: 4.sp),
              ),
            );
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 1.w),
            );
          },
        );
      },
      error: (error, stacktrace) {
        return Center(
          child: Text(
            error.toString(),
            style: TextStyle(fontSize: 4.sp),
          ),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(strokeWidth: 1.w),
        );
      },
    );
  }
}
