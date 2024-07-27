part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}
//related only with states

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid; //USERMODEL can be instead

  AuthSuccess({required this.uid});
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}
