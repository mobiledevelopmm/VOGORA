
enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? userName;
  final String? userEmail;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userName,
    this.userEmail,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? userName,
    String? userEmail,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
