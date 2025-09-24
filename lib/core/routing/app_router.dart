import 'dart:io';

import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/auth/cubit/auth_cubit.dart';
import 'package:appfactorytest/feature/auth/presentation/screen/sgin_up_screen.dart';
import 'package:appfactorytest/feature/auth/presentation/screen/login_screens.dart';
import 'package:appfactorytest/feature/auth/repo/auth_repo.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
import 'package:appfactorytest/feature/home/presentation/screen/add_post.dart';
import 'package:appfactorytest/feature/home/presentation/screen/delails.dart';
import 'package:appfactorytest/feature/home/presentation/screen/home_screen.dart';
import 'package:appfactorytest/feature/main_layout/cubit/main_lay_out_cubit.dart';
import 'package:appfactorytest/feature/main_layout/presentation/Screen/main_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainLayout:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => MainLayOutCubit(),
            child: Builder(
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    final shouldPop = await _showExitConfirmationDialog(
                      context,
                    );
                    return shouldPop ?? false;
                  },
                  child: MainLayOut(),
                );
              },
            ),
          ),
        );
      case Routes.addPost:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
          child: AddPostScreen(),
        );
      case Routes.detailsScreen:
        var args = settings.arguments as PostModel;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
          child: PostDetailsScreen(post: args),
        );
      case Routes.homeScreen:
        return PageTransition(
          child: Builder(
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  final shouldPop = await _showExitConfirmationDialog(context);
                  return shouldPop ??
                      false; // Return true if the user confirms exit, else false
                },
                child: const HomeScreen(),
              );
            },
          ),
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
        );

      case Routes.signUpScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
          child: BlocProvider(
            create: (context) => AuthCubit(AuthRepo()),
            child: Builder(
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async {
                    final shouldPop = await _showExitConfirmationDialog(
                      context,
                    );
                    return shouldPop ??
                        false; // Return true if the user confirms exit, else false
                  },
                  child: const SignUpScreen(),
                );
              },
            ),
          ),
        );

      case Routes.loginScreen:
        return PageTransition(
          child: Builder(
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  final shouldPop = await _showExitConfirmationDialog(context);
                  return shouldPop ?? false;
                },
                child: BlocProvider(
                  create: (context) => AuthCubit(AuthRepo()),
                  child: const LoginScreen(),
                ),
              );
            },
          ),
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: settings,
        );

      default:
        return PageTransition(
          child: Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
        );
    }
  }
}

Future<bool?> _showExitConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text14(text: 'Exit!', textColor: AppColors.black),
      content: Text12(
        text: 'Do you want to leave the app?',
        textColor: AppColors.black,
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.grey),
          ),
          onPressed: () => Navigator.of(context).pop(false), // Stay in the app
          child: Text12(text: 'No', textColor: AppColors.greyFont),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.red),
          ),
          onPressed: () => exit(0), // Exit the app
          child: Text12(text: 'Yes', textColor: AppColors.blue),
        ),
      ],
    ),
  );
}
