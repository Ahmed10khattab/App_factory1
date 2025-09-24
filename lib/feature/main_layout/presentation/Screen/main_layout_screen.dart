
import 'package:appfactorytest/feature/home/presentation/screen/home_screen.dart';
import 'package:appfactorytest/feature/main_layout/cubit/main_lay_out_cubit.dart';
import 'package:appfactorytest/feature/main_layout/presentation/widgets/nav_bar.dart';
import 'package:appfactorytest/feature/notification/notification.dart';
import 'package:appfactorytest/feature/notification/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainLayOut extends StatefulWidget {
  const MainLayOut({super.key});

  @override
  State<MainLayOut> createState() => _MainLayOutState();
}

class _MainLayOutState extends State<MainLayOut> {
  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      const HomeScreen(),
      const NotificationScreen(),
      ProfileScreen(),
      const NotificationScreen(),
    ];

  
    return SafeArea(
      child: BlocBuilder<MainLayOutCubit, MainLayOutState>(
        builder: (context, state) {
          var cubit = MainLayOutCubit.get(context);
          int index = cubit.selectNaveBarIndex!;
          return Scaffold(
            body: pages[index],
            bottomNavigationBar: CustomNavBar(),
          );
        },
      ),
    );
  }
}
