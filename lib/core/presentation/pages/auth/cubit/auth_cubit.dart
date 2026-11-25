
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  late final StreamSubscription<User?> _authSubscription;

  AuthCubit(this._authService) : super(const AuthState()) {
    _authSubscription = _authService.authStateChanges.listen(
      _onAuthChanged,
      onError: (_) {
        if (!isClosed) {
          emit(const AuthState(
            status: AuthStatus.error,
            errorMessage: 'Unable to check authentication status.',
          ));
        }
      },
    );
  }

  // Listen to Firebase Authentication changes
  Future<void> _onAuthChanged(User? user) async {
    if (isClosed) return;

    if (user == null) {
      emit(const AuthState(
        status: AuthStatus.unauthenticated,
      ));
      return;
    }

    await _checkUserGender(user);
  }


  Future<void> _checkUserGender(User user) async {
    try {
      final gender = await _authService.getUserGender(user.uid);
      final age = await _authService.getUserAge(user.uid);

      if (isClosed) return;

      if (gender == null) {
        emit(AuthState(
          status: AuthStatus.needsGenderSelection,
          userName: user.displayName,
          userEmail: user.email,
          userAge: age,
        ));
      } else {
        emit(AuthState(
          status: AuthStatus.authenticated,
          userName: user.displayName,
          userEmail: user.email,
          userGender: gender,
          userAge: age,
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Unable to load your profile. Please try again.',
        ));
      }
    }
  }

  // Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      clearError: true,
    ));

    try {
      await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      final user = _authService.currentUser;

      if (user != null && !isClosed) {
        await _checkUserGender(user);
      }
    } on FirebaseAuthException catch (e) {
      if (!isClosed) {
        emit(AuthState(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Something went wrong. Please try again.',
        ));
      }
    }
  }

  // Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      clearError: true,
    ));

    try {
      await _authService.login(
        email: email,
        password: password,
      );

      final user = _authService.currentUser;

      if (user != null && !isClosed) {
        await _checkUserGender(user);
      }
    } on FirebaseAuthException catch (e) {
      if (!isClosed) {
        emit(AuthState(
          status: AuthStatus.error,
          errorMessage: _getErrorMessage(e.code),
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Something went wrong. Please try again.',
        ));
      }
    }
  }

  // Save selected gender
  Future<void> saveGender(String gender) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      clearError: true,
    ));

    try {
      await _authService.saveGender(gender);

      final user = _authService.currentUser;

      if (user != null && !isClosed) {
        emit(AuthState(
          status: AuthStatus.authenticated,
          userName: user.displayName,
          userEmail: user.email,
          userGender: gender,
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Unable to save your gender. Please try again.',
        ));
      }
    }
  }

  Future<void> updatePersonalInfo({
    required String name,
    required String gender,
    int? age,
  }) async {
    final previousState = state;

    emit(state.copyWith(
      status: AuthStatus.loading,
      clearError: true,
    ));

    try {
      await _authService.updatePersonalInfo(
        name: name,
        gender: gender,
        age: age,
      );

      final user = _authService.currentUser;

      if (user != null && !isClosed) {
        // Reload saved information from Firestore.
        final savedGender =
        await _authService.getUserGender(user.uid);

        final savedAge =
        await _authService.getUserAge(user.uid);

        await user.reload();

        final updatedUser = _authService.currentUser;

        if (!isClosed) {
          emit(AuthState(
            status: AuthStatus.authenticated,
            userName: updatedUser?.displayName ?? name,
            userEmail: updatedUser?.email,
            userGender: savedGender ?? gender,
            userAge: savedAge,
          ));
        }
      }
    } catch (e) {
      debugPrint('Update Personal Info Error: $e');

      if (!isClosed) {
        emit(previousState.copyWith(
          status: AuthStatus.authenticated,
          errorMessage:
          'Unable to update your information. Please try again.',
        ));
      }
    }
  }

  // Logout
  Future<void> logout() async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      clearError: true,
    ));

    try {
      await _authService.logout();

      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.unauthenticated,
        ));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const AuthState(
          status: AuthStatus.error,
          errorMessage: 'Unable to log out. Please try again.',
        ));
      }
    }
  }

  // Firebase error messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
