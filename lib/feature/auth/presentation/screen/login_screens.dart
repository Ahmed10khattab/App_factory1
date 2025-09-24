import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/helpers/flutter_toast.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_button.dart';
import 'package:appfactorytest/core/widgets/custom_text_form_field.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/auth/cubit/auth_cubit.dart';
import 'package:appfactorytest/feature/main_layout/cubit/main_lay_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailCnt = TextEditingController();
    final TextEditingController passCnt = TextEditingController();

    return SafeArea(
      child: BlocProvider(
        create: (context) => MainLayOutCubit(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text28(
                            text: "Welcome back",
                            textColor: AppColors.black,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormFeild(
                            controller: emailCnt,
                            hint: "Email",
                            validator: (val) =>
                                val!.isEmpty ? "please enter Email" : null,
                          ),
                          SizedBox(height: 20),
                          CustomTextFormFeild(
                            controller: passCnt,
                            hint: "Password",
                            validator: (val) =>
                                val!.isEmpty ? "please enter Password" : null,
                          ),
                          SizedBox(height: 20),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthAuthenticated) {
                                context.pushReplacementNamed(Routes.mainLayout);
                              } else if (state is AuthError) {
                                ToastManager.showErrorToast(
                                  "faild",
                                  context,
                                  "email or password not correct",
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
                                text: 'login',
                                color: AppColors.blue,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.white,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      emailCnt.text.trim(),
                                      passCnt.text.trim(),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14(
                        text: "Create New account? ",
                        textColor: AppColors.greyFont,
                        weight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {
                          context.pushReplacementNamed(Routes.signUpScreen);
                        },
                        child: Text14(
                          text: "Sign up",
                          textColor: AppColors.greyFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
