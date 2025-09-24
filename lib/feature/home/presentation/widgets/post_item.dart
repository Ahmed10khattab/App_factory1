import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/feature/home/cubit/posts_cubit.dart';
import 'package:appfactorytest/feature/home/presentation/widgets/home_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return RefreshIndicator(
            onRefresh: () async {
              await PostCubit.get(context).fetchPosts();
            },
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _shimmer();
              },
            ),
          );
        } else if (state is PostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return HomeCartItem(post: state.posts[index]);
            },
          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.white,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}
