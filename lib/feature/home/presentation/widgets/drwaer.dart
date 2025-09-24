import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/auth/cubit/auth_cubit.dart';
import 'package:appfactorytest/feature/auth/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocProvider(
        create: (context) => AuthCubit(AuthRepo()),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 40),
                InkWell(
                  onTap: () {
                    CacheHelper.clearAllData();
                    AuthCubit.get(context).logout();
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.
                    symmetric(horizontal:20),
                    child: Row(
                      spacing: 20.w,
                      children: [
                        Icon(Icons.logout,size: 25,),
                        
                        Text16(text: "Log Out"),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
