
enum AuthStatus {
  initial,
  loading,
  authenticated,
  needsGenderSelection,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? userName;
  final String? userEmail;
  final String? userGender;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userName,
    this.userEmail,
    this.userGender,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? userName,
    String? userEmail,
    String? userGender,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage:
      clearError ? null : errorMessage ?? this.errorMessage,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userGender: userGender ?? this.userGender,
    );
  }
}
