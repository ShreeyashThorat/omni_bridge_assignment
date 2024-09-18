part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterWithEmailAndPass extends RegisterEvent {
  final String email;
  final String pass;
  final String name;
  final String contact;
  const RegisterWithEmailAndPass(
      {required this.email,
      required this.pass,
      required this.contact,
      required this.name});
}
