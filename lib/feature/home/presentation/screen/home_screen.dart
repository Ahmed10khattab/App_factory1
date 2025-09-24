import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/routing/routes.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/feature/home/cubit/posts_cubit.dart';
import 'package:appfactorytest/feature/home/presentation/banner_ad/banner_service.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/drwaer.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/home_header.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/person_list.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/post_item.dart';
import 'package:appfactorytest/feature/home/repo/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AdManager.instance.loadInterstitial();
    AdManager.instance.loadBanner(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
    );
  }

  @override
  void dispose() {
    AdManager.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: BlocProvider(
          create: (context) => PostCubit(PostRepository())..fetchPosts(),
          child: BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await PostCubit.get(context).fetchPosts();
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      HomeHeader(),
                      SizedBox(height: 14.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Suggested",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PersonList(),
                      SizedBox(height: 14.h),
                      Expanded(child: PostItem()),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFabPressed,
          child: Container(
            height: 56.h,
            width: 64.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child:  Icon(Icons.add,color: AppColors.white),
          ),
        ),
      ),
    );
  }

  void _onFabPressed() {
    AdManager.instance.showInterstitial(
      onAdDismissed: () {
        context.pushNamed(Routes.addPost);
      },
    );
  }
}
