part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessfully extends LoginState {}

class LoginError extends LoginState {
  final AppException exception;
  const LoginError({required this.exception});
}
