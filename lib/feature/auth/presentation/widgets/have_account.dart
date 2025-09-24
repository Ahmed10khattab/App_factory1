import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';

class HaveAccountQuestion extends StatelessWidget {
  const HaveAccountQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text14(
                      text: "Already have an account? ",
                      textColor: AppColors.greyFont,
                      weight: FontWeight.bold,
                    ),

                    InkWell(
                      onTap: () {
                        context.pushNamed(Routes.loginScreen);
                      },
                      child: Text14(
                        text: "Log in",
                        textColor: AppColors.greyFont,
                      ),
                    ),
                  ],
                );
  }
}