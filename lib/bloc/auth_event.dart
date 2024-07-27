part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
//related only with events

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}
