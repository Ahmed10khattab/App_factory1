import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/cache_helper/cache_values.dart';
import 'package:appfactorytest/core/helpers/easy_loading.dart';
import 'package:appfactorytest/feature/auth/repo/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());
static AuthCubit get(context)=>BlocProvider.of(context);
  /// Sign Up
  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signUp(
        userName: userName,
        email: email,
        password: password,
      );
      if (user != null) {
        emit(AuthAuthenticated(user));
        
      } else {
        emit(AuthError("Sign up failed."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
Future<void> signInWithGoogle() async {
    emit(AuthGoogleLoading());
    try {
      final user = await authRepo.signInWithGoogle();
      if (user != null) {
        emit(AuthGoogleAuthenticated(user: user));
        CacheHelper.saveData(key: CacheKeys.userId, value: user.uid);
      } else {
        emit(AuthError("Google sign-in canceled."));
      }
    } catch (e) {
      emit(AuthGoogleError(e.toString()));
    }
  }

  /// Login
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.login(email: email, password: password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Login failed."));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Logout
  Future<void> logout() async {
  showLoading();
    await authRepo.logout();
    emit(AuthLoggedOut());
    hideLoading();
    
  }
}
