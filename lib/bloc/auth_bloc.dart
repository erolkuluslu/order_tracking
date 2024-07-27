import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      final email = event.email;
      final password = event.password;

      print('AuthLoginRequested Event Received: $email, $password');

      if (password.length < 6) {
        emit(AuthFailure(error: 'Password cannot be less than 6 characters'));
        print('AuthFailure: Password cannot be less than 6 characters');
        return;
      }

      try {
        print('Starting login process...');
        await Future.delayed(const Duration(seconds: 1), () {
          print('Simulating successful login...');
          emit(AuthSuccess(uid: "$email-$password"));
          print('AuthSuccess: $email-$password');
        });
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
        print('AuthFailure: ${e.toString()}');
      }
    });
  }
}
