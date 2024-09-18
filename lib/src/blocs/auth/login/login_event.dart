part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailAndPass extends LoginEvent {
  final String email;
  final String pass;
  const LoginWithEmailAndPass({required this.email, required this.pass});
}
