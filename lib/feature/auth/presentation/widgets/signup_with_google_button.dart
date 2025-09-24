import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/helpers/flutter_toast.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_button.dart';
import 'package:appfactorytest/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpWithGoogleButton extends StatelessWidget {
  const SignUpWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthGoogleAuthenticated) {
           ToastManager.showSuccessToast("Success", context,"Welcome! You created a new email.");
          context.pushReplacementNamed(Routes.mainLayout);
        } else if (state is AuthGoogleError) {
          ToastManager.showErrorToast("faild", context, "SomeThing Went Wrong");
        }
      },
      builder: (context, state) {
        if (state is AuthGoogleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomButton(
          borderRadius: 24.r,
          height: 48.h,
          text: 'Sign Up with Google',
          color: AppColors.grey,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          onPressed: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        );
      },
    );
  }
}
