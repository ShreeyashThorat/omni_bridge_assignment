part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessfully extends RegisterState {}

class RegisterError extends RegisterState {
  final AppException exception;
  const RegisterError({required this.exception});
}
