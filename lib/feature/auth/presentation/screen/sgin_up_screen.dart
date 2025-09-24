import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/helpers/flutter_toast.dart';
import 'package:appfactorytest/core/helpers/regex.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_button.dart';
import 'package:appfactorytest/core/widgets/custom_text_form_field.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/auth/cubit/auth_cubit.dart';
import 'package:appfactorytest/feature/auth/presentation/widgets/have_account.dart';
import 'package:appfactorytest/feature/auth/presentation/widgets/signup_with_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailCnt = TextEditingController();
    final TextEditingController passCnt = TextEditingController();
    final TextEditingController userName = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  children: [
                    SizedBox(height: 40),
                    Align(
                      child: Text28(
                        text: "Create an account",
                        textColor: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFeild(
                      controller: userName,
                      hint: "userName",
                      validator: (val) =>
                          val!.isEmpty ? "please enter userName" : null,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFeild(
                      controller: emailCnt,
                      hint: "Email",
                      validator: (val) => AppRegex.email(val),
                    ),
                    SizedBox(height: 20),
                    CustomTextFormFeild(
                      controller: passCnt,
                      hint: "Password",
                      validator: (val) => AppRegex.password(val),
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          ToastManager.showSuccessToast(
                            "Success",
                            context,
                            "Welcome! You created a new email.",
                          );
                          context.pushReplacementNamed(Routes.mainLayout);
                        } else if (state is AuthError) {
                          ToastManager.showErrorToast(
                            "faild",
                            context,
                            "email or password not availavble",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return CustomButton(
                          borderRadius: 24.r,
                          height: 48.h,
                          text: 'SignUp',
                          color: AppColors.blue,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signUp(
                                userName: userName.text.trim(),
                                email: emailCnt.text.trim(),
                                password: passCnt.text.trim(),
                              );
                            }
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20),
                    SignUpWithGoogleButton(),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              /// ده هينزل تحت خالص
              HaveAccountQuestion(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
