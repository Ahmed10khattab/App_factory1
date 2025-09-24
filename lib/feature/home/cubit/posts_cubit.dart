import 'package:appfactorytest/core/helpers/easy_loading.dart';
import 'package:appfactorytest/core/helpers/flutter_toast.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
import 'package:appfactorytest/feature/home/repo/posts_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;

  PostCubit(this.repository) : super(PostInitial());
  static PostCubit get(context) => BlocProvider.of(context);
  Future<void> fetchPosts() async {
    emit(PostLoading());
    try {
      final posts = await repository.getPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Error fetching posts: $e"));
    }
  }

  Future<void> addPost(PostModel post, context) async {
    try {
      showLoading();
      await repository.addPost(post);

      fetchPosts();
      ToastManager.showSuccessToast(
        "Success",
        context,
        "Post Added successfully",
      );

      hideLoading(); // refresh
    } catch (e) {
      hideLoading();
      emit(PostError("Error adding post: $e"));
    }
  }

  Future<void> toggleLike(PostModel post) async {
    try {
      await repository.toggleLike(post);
      // fetchPosts(); // refresh
    } catch (e) {
      emit(PostError("Error updating like: $e"));
    }
  }
}
